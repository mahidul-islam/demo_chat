import 'package:demo_chat/login/view/login_view.dart';
import 'package:demo_chat/register/view/register_view.dart';
import 'package:demo_chat/rooms.dart';
import 'package:demo_chat/users.dart';
import 'package:go_router/go_router.dart';

enum Routes { login, register, users, room }

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
    GoRoute(
      name: Routes.users.name,
      path: '/users',
      builder: (context, state) => const UsersPage(),
    ),
    GoRoute(
      name: Routes.room.name,
      path: '/room',
      builder: (context, state) => const RoomsPage(),
    ),
  ],
);
