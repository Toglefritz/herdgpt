import 'package:go_router/go_router.dart';
import 'package:herdgpt/screens/landing/landing_route.dart';

/// GoRouter configuration.
///
/// This global variable defines routes used with the *go_router* package.
GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingRoute(),
    ),
  ],
);
