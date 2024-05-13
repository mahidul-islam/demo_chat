import 'package:demo_chat/chat_room/provider/chat_room_provider.dart';
import 'package:demo_chat/chat_room/widget/avatar_widget.dart';
import 'package:demo_chat/chat_room/widget/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatRoomScreen extends HookConsumerWidget {
  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomStream = ref.watch(chatRoomStreamProvider);
    final authUserStream = ref.watch(authUserStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: authUserStream.when(
              data: (User? user) {
                return Text(user?.displayName ?? '--');
              },
              error: (Object error, StackTrace stackTrace) {
                return const Text('Chat room');
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            ) ??
            const Text('Chat room'),
      ),
      body: chatRoomStream.when(
        data: (List<types.Room> rooms) {
          if (rooms.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No rooms'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final room = rooms[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        room: room,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      authUserStream.when(
                            data: (User? user) {
                              return AvatarWidget(user: user, room: room);
                            },
                            error: (Object error, StackTrace stackTrace) {
                              return const SizedBox.shrink();
                            },
                            loading: () {
                              return const SizedBox.shrink();
                            },
                          ) ??
                          const SizedBox.shrink(),
                      Text(room.name ?? ''),
                    ],
                  ),
                ),
              );
            },
            itemCount: rooms.length,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}
