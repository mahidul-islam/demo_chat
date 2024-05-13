import 'package:demo_chat/login/provider/login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'register_provider.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  AuthenticationState build() {
    return AuthenticationState.initial;
  }

  void register(String email, String password, String name) async {
    try {
      state = AuthenticationState.loading;
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AuthenticationState.success;
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: name,
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=$email',
        ),
      );
    } catch (e) {
      state = AuthenticationState.error;
    }
  }
}
