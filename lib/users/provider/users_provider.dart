import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final usersStreamProvider = StreamProvider.autoDispose<List<types.User>>((ref) {
  final Stream<List<types.User>> stream = FirebaseChatCore.instance.users();
  ref.onDispose(() {
    stream.listen(null).cancel();
  });
  return stream;
});
