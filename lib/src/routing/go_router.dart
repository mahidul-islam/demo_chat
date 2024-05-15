import 'package:demo_chat/src/features/chat_room/view/chat_room_view.dart';
import 'package:demo_chat/src/features/login/view/login_view.dart';
import 'package:demo_chat/src/features/register/view/register_view.dart';
import 'package:demo_chat/src/features/users/view/users_list_view.dart';
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
      builder: (context, state) => const UserListScreen(),
    ),
    GoRoute(
      name: Routes.room.name,
      path: '/room',
      builder: (context, state) => const ChatPage(),
    ),
  ],
);
