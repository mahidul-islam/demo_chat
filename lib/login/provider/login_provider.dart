import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

enum AuthenticationState {
  initial,
  loading,
  success,
  error,
}

@riverpod
class LoginFunctions extends _$LoginFunctions {
  @override
  AuthenticationState build() {
    return AuthenticationState.initial;
  }

  void login(String email, String password) async {
    try {
      state = AuthenticationState.loading;
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
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
