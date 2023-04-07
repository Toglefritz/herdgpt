import 'package:go_router/go_router.dart';
import 'package:herdgpt/screens/landing/landing_route.dart';
import 'package:herdgpt/screens/landing/privacy_policy/privacy_policy_route.dart';
import 'package:herdgpt/screens/landing/terms_and_conditions/terms_and_conditions_route.dart';

/// GoRouter configuration.
///
/// This global variable defines routes used with the *go_router* package.
GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: const LandingRoute().screenName,
      builder: (context, state) => const LandingRoute(),
    ),
    GoRoute(
      path: const TermsAndConditionsRoute().screenName,
      builder: (context, state) => const TermsAndConditionsRoute(),
    ),
    GoRoute(
      path: const PrivacyPolicyRoute().screenName,
      builder: (context, state) => const PrivacyPolicyRoute(),
    ),
  ],
);
