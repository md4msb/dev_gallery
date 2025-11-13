import 'package:dev_gallery/features/developers/presentation/screen/developer_detail_screen.dart';
import 'package:dev_gallery/features/developers/presentation/screen/developers_screen.dart';
import 'package:dev_gallery/features/developers/presentation/screen/favorites_screen.dart';
import 'package:dev_gallery/features/developers/presentation/screen/search_screen.dart';
import 'package:dev_gallery/main_app_shell.dart';
import 'package:dev_gallery/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'router_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) =>
          MainAppShell(navigationShell: navShell),
      branches: [
        /// Home tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: RouteNames.home,
              builder: (context, state) => const DevelopersScreen(),
            ),
          ],
        ),

        /// Search tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              name: RouteNames.search,
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),

        /// Favorites tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              name: RouteNames.favorites,
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
      ],
    ),

    /// Developer detail page
    GoRoute(
      path: RouteNames.developerDetails,
      name: 'developerDetails',
      builder: (context, state) {
        // final username = state.pathParameters['username']!;
        return DeveloperDetailScreen();
      },
    ),
  ],
);
