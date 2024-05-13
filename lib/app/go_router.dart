import 'package:demo_chat/login/view/login_view.dart';
import 'package:demo_chat/register/view/register_view.dart';
import 'package:go_router/go_router.dart';

enum Routes { login, register }

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: Routes.login.name,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: Routes.register.name,
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
