import 'package:demo_chat/counter/view/counter_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CounterPage(),
    ),
    // GoRoute(
    //   path: '/details',
    //   builder: (context, state) => const DetailsScreen(),
    // ),
  ],
);
