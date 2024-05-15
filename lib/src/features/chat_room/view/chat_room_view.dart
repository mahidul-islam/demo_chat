import 'dart:io';
import 'package:demo_chat/src/routing/go_router.dart';
import 'package:demo_chat/src/features/chat_room/provider/chat_room_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(roomProvider.notifier).state;
    final isAttachmentUploading = useState(false);

    void handleImageSelection() async {
      final result = await ImagePicker().pickImage(
        imageQuality: 70,
        maxWidth: 1440,
        source: ImageSource.gallery,
      );

      if (result != null) {
        isAttachmentUploading.value = true;

        final size = await result.length();
        final bytes = await result.readAsBytes();
        final image = await decodeImageFromList(bytes);
        final name = result.name;

        try {
          final reference = FirebaseStorage.instance.ref(name);
          await reference.putData(bytes);
          final uri = await reference.getDownloadURL();

          final message = types.PartialImage(
            height: image.height.toDouble(),
            name: name,
            size: size,
            uri: uri,
            width: image.width.toDouble(),
          );

          FirebaseChatCore.instance.sendMessage(
            message,
            room?.id ?? '',
          );
        } finally {
          isAttachmentUploading.value = false;
        }
      }
    }

    void handleMessageTap(BuildContext _, types.Message message) async {
      if (message is types.FileMessage) {
        var localPath = message.uri;

        if (message.uri.startsWith('http')) {
          try {
            final updatedMessage = message.copyWith(isLoading: true);
            FirebaseChatCore.instance.updateMessage(
              updatedMessage,
              room?.id ?? '',
            );

            final client = http.Client();
            final request = await client.get(Uri.parse(message.uri));
            final bytes = request.bodyBytes;
            final documentsDir =
                (await getApplicationDocumentsDirectory()).path;
            localPath = '$documentsDir/${message.name}';

            if (!File(localPath).existsSync()) {
              final file = File(localPath);
              await file.writeAsBytes(bytes);
            }
          } finally {
            final updatedMessage = message.copyWith(isLoading: false);
            FirebaseChatCore.instance.updateMessage(
              updatedMessage,
              room?.id ?? '',
            );
          }
        }

        await OpenFilex.open(localPath);
      }
    }

    void handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
    ) {
      final updatedMessage = message.copyWith(previewData: previewData);

      FirebaseChatCore.instance.updateMessage(
        updatedMessage,
        room?.id ?? '',
      );
    }

    void handleSendPressed(types.PartialText message) {
      FirebaseChatCore.instance.sendMessage(
        message,
        room?.id ?? '',
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pushReplacementNamed(Routes.users.name),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Chat'),
      ),
      body: StreamBuilder<types.Room>(
        initialData: room,
        stream: FirebaseChatCore.instance.room(room?.id ?? ''),
        builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
          initialData: const [],
          stream: FirebaseChatCore.instance.messages(snapshot.data!),
          builder: (context, snapshot) => Chat(
            isAttachmentUploading: isAttachmentUploading.value,
            messages: snapshot.data ?? [],
            onAttachmentPressed: handleImageSelection,
            onMessageTap: handleMessageTap,
            onPreviewDataFetched: handlePreviewDataFetched,
            onSendPressed: handleSendPressed,
            user: types.User(
              id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
