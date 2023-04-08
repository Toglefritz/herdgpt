import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:herdgpt/screens/authentication/authentication_route.dart';
import 'package:herdgpt/screens/create_account/create_account_route.dart';
import 'package:herdgpt/screens/landing/landing_route.dart';
import 'package:herdgpt/screens/login/login_route.dart';
import 'package:herdgpt/screens/privacy_policy/privacy_policy_route.dart';
import 'package:herdgpt/screens/team_setup/team_setup_route.dart';
import 'package:herdgpt/screens/terms_and_conditions/terms_and_conditions_route.dart';

/// GoRouter configuration.
///
/// This global variable defines routes used with the *go_router* package.
GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: const LandingRoute().screenName,
      builder: (context, state) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return const TeamSetupRoute();
          }
          return const LandingRoute();
        },
      ),
    ),
    GoRoute(
      path: const TermsAndConditionsRoute().screenName,
      builder: (context, state) => const TermsAndConditionsRoute(),
    ),
    GoRoute(
      path: const PrivacyPolicyRoute().screenName,
      builder: (context, state) => const PrivacyPolicyRoute(),
    ),
    GoRoute(
      path: const LoginRoute().screenName,
      builder: (context, state) => const LoginRoute(),
    ),
    GoRoute(
      path: const CreateAccountRoute().screenName,
      builder: (context, state) => const CreateAccountRoute(),
    ),
    GoRoute(
      path: const AuthenticationRoute().screenName,
      builder: (context, state) => const AuthenticationRoute(),
    ),
    GoRoute(
      path: const TeamSetupRoute().screenName,
      builder: (context, state) => const TeamSetupRoute(),
    ),
  ],
);
