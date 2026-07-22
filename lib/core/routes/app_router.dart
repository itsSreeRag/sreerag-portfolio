import 'package:go_router/go_router.dart';
import '../../features/shell/views/main_shell_view.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainShellView(initialSection: 'Home'),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const MainShellView(initialSection: 'About'),
      ),
      GoRoute(
        path: '/projects',
        name: 'projects',
        builder: (context, state) => const MainShellView(initialSection: 'Projects'),
      ),
      GoRoute(
        path: '/experience',
        name: 'experience',
        builder: (context, state) => const MainShellView(initialSection: 'Experience'),
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        builder: (context, state) => const MainShellView(initialSection: 'Contact'),
      ),
    ],
    errorBuilder: (context, state) => const MainShellView(initialSection: 'Home'),
  );
}
