import 'package:demo_chat/src/constants/enums.dart';
import 'package:demo_chat/src/routing/go_router.dart';
import 'package:demo_chat/src/features/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final AuthenticationState loginState = ref.watch(loginFunctionsProvider);

    ref.listen(loginFunctionsProvider, (previous, next) {
      if (next == AuthenticationState.success) {
        context.goNamed(Routes.users.name);
        // Go to chat
      } else if (next == AuthenticationState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Something went wrong'),
          ),
        );
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                helperText: 'Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                helperText: 'Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.amberAccent,
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      ref
                          .read(loginFunctionsProvider.notifier)
                          .login(emailController.text, passwordController.text);
                    }
                  },
                  child: loginState != AuthenticationState.loading
                      ? const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        )
                      : const CircularProgressIndicator(),
                ),
                const SizedBox(
                  width: 20,
                  height: 20,
                ),
                const Text(
                    'Do not have an account? Register by clicking below'),
                const SizedBox(
                  width: 20,
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.amberAccent,
                  onPressed: () async {
                    context.goNamed(Routes.register.name);
                  },
                  child: const Text(
                    'Register now',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
