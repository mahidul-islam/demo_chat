import 'package:demo_chat/app/go_router.dart';
import 'package:demo_chat/login/provider/login_provider.dart';
import 'package:demo_chat/register/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final firstNameController = useTextEditingController();

    final AuthenticationState loginState = ref.watch(authenticationProvider);
    // ref.listen(authErrorMessageProvider, (prev, next) {
    //   if (next.isNotEmpty) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(next),
    //       ),
    //     );
    //   } else {
    //     emailController.text = '';
    //     passwordController.text = '';
    //   }
    // });

    ref.listen(authenticationProvider, (previous, next) {
      if (next == AuthenticationState.success) {
        context.pushReplacementNamed(Routes.users.name);
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
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                helperText: 'First name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.amberAccent,
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        firstNameController.text.isNotEmpty) {
                      ref.read(authenticationProvider.notifier).register(
                          emailController.text,
                          passwordController.text,
                          firstNameController.text);
                    }
                  },
                  child: loginState != AuthenticationState.loading
                      ? const Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        )
                      : const CircularProgressIndicator(),
                ),
                const SizedBox(
                  width: 20,
                  height: 20,
                ),
                const Text('Already have an account? Login by clicking below'),
                const SizedBox(
                  width: 20,
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.amberAccent,
                  onPressed: () async {
                    context.pushReplacementNamed(Routes.login.name);
                  },
                  child: const Text(
                    'Login',
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
