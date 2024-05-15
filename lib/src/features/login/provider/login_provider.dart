import 'package:demo_chat/src/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
class LoginFunctions extends _$LoginFunctions {
  @override
  AuthenticationState build() {
    return AuthenticationState.initial;
  }

  void login(String email, String password) async {
    try {
      state = AuthenticationState.loading;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AuthenticationState.success;
    } catch (e) {
      state = AuthenticationState.error;
    }
  }
}
