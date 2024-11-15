import 'package:go_router/go_router.dart';
import 'package:go_router_navigation_system_flutter/navigation/navigation_bar.dart';
import 'package:go_router_navigation_system_flutter/screens/home.dart';
import 'package:go_router_navigation_system_flutter/screens/profile.dart';

final List<GoRoute> navigationRoutes = [
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) => const ProfilePage(),
  ),
];

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavigation(navigationShell: navigationShell);
      },
      branches: navigationRoutes
          .map((route) => StatefulShellBranch(routes: [route]))
          .toList(),
    ),
  ],
);
