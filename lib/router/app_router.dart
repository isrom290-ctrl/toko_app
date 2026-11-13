import 'package:go_router/go_router.dart';

import '../pages/app_shell.dart';
import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/not_found_page.dart';
import '../pages/product_detail_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../pages/splash_screen.dart';
import '../routes/app_routes.dart';
import '../state/auth_state.dart';
import '../state/cart_state.dart';

GoRouter createRouter({
  required AuthState authState,
  required CartState cartState,
}) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authState,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isPublicRoute =
          location == AppRoutes.splash || location == AppRoutes.login;

      if (authState.isLoggedIn && location == AppRoutes.splash) {
        return AppRoutes.home;
      }
      if (!authState.isLoggedIn && !isPublicRoute) {
        return AppRoutes.login;
      }
      if (authState.isLoggedIn && location == AppRoutes.login) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginPage(authState: authState),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell, cartState: cartState),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => HomePage(authState: authState),
                routes: [
                  GoRoute(
                    path: 'product/:id',
                    builder: (context, state) => ProductDetailPage(
                      productId: state.pathParameters['id']!,
                      cartState: cartState,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.search,
                builder: (context, state) => const SearchPage(),
                routes: [
                  GoRoute(
                    path: 'product/:id',
                    builder: (context, state) => ProductDetailPage(
                      productId: state.pathParameters['id']!,
                      cartState: cartState,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cart,
                builder: (context, state) => CartPage(cartState: cartState),
                routes: [
                  GoRoute(
                    path: 'checkout',
                    builder: (context, state) =>
                        CheckoutPage(cartState: cartState),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => ProfilePage(authState: authState),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        NotFoundPage(location: state.uri.toString()),
  );
}
