import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final chatRoomStreamProvider =
    StreamProvider.autoDispose<List<types.Room>>((ref) {
  final Stream<List<types.Room>> stream = FirebaseChatCore.instance.rooms();
  ref.onDispose(() {
    stream.listen(null).cancel();
  });
  return stream;
});

final authUserStreamProvider = StreamProvider.autoDispose<User?>((ref) {
  final Stream<User?> stream = FirebaseAuth.instance.authStateChanges();
  ref.onDispose(() {
    stream.listen(null).cancel();
  });
  return stream;
});
