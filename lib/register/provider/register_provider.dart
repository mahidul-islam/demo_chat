import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

enum AuthenticationState {
  initial,
  loading,
  success,
  error,
}

@riverpod
class Authentication extends _$Authentication {
  @override
  AuthenticationState build() {
    return AuthenticationState.initial;
  }

  void register(String email, String password) async {
    try {
      state = AuthenticationState.loading;
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AuthenticationState.success;
      print(credential.toString());
      // await FirebaseChatCore.instance.createUserInFirestore(
      //   types.User(
      //     firstName: _firstName,
      //     id: credential.user!.uid,
      //     imageUrl: 'https://i.pravatar.cc/300?u=$_email',
      //     lastName: _lastName,
      //   ),
      // );
    } catch (e) {
      state = AuthenticationState.error;
      print(e.toString());
    }
  }
}
