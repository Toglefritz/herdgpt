import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/navigable_page_controller.dart';
import '../../services/firebase/authentication/sign_in_with_google.dart';
import '../../values/regex.dart';
import '../loading/loading_view.dart';
import '../team_and_project_setup/team_and_project_setup_route.dart';
import 'login_route.dart';
import 'login_view.dart';

/// Controller for the [CreateAccountRoute].

class LoginController extends NavigablePageController<LoginRoute> {
  /// A key used for the username and password login form.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// A controller used for the username field.
  final TextEditingController usernameFieldController = TextEditingController();

  /// A controller used for the password field.
  final TextEditingController passwordFieldController = TextEditingController();

  /// An additional error string set by exceptions thrown during the login process related to the username entry.
  String? loginUsernameExceptionError;

  /// An additional error string set by exceptions thrown during the login process related to the password entry.
  String? loginPasswordExceptionError;

  /// Determines if the account creation process is in progress
  bool _loginProcessing = false;

  @override
  void initState() {
    if (kDebugMode == false) {
      FirebaseAnalytics.instance.logScreenView();
    }

    super.initState();
  }

  /// Handles taps on the button to create an account with Google.
  Future<void> handleCreateAccountWithGoogle() async {
    try {
      await signInWithGoogle();

      if (!mounted) return;
      context.go(const TeamAndProjectSetupRoute().screenName);
    } catch (e) {
      debugPrint('Failed to sign in with Google with exception, $e');
    }
  }

  /// Validates the username field.
  String? validateUsernameField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Oh no! Please enter a username.';
    } else if (!RegEx.emailAddress.hasMatch(value)) {
      return 'Is this a valid email address?';
    }

    return null;
  }

  /// Validates the password field.
  String? validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    } else if (value.length < 6) {
      return 'You\'ll need a longer password.';
    }

    return null;
  }

  /// Handles submission of the username and password to perform basic authentication against Firebase.
  Future<void> handleBasicAuthLoginSubmit() async {
    setState(() {
      loginUsernameExceptionError = null;
      loginPasswordExceptionError = null;
      _loginProcessing = true;
    });

    if (formKey.currentState!.validate()) {
      setState(() {
        _loginProcessing = true;
      });

      try {
        UserCredential? userCredential = await login(
          emailAddress: usernameFieldController.text,
          password: passwordFieldController.text,
        );

        debugPrint('User, ${userCredential?.user}, successfully authenticated');

        if (!mounted) return;
        context.go(const TeamAndProjectSetupRoute().screenName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            loginUsernameExceptionError = 'No user found with that email.';
            _loginProcessing = false;
          });

          return;
        } else if (e.code == 'wrong-password') {
          setState(() {
            loginPasswordExceptionError = 'That password wasn\'t quite right.';
            _loginProcessing = false;
          });

          return;
        } else if (e.code == 'user-disabled') {
          setState(() {
            loginUsernameExceptionError = 'Your account is currently disabled.';
            _loginProcessing = false;
          });

          return;
        }
      }
    }

    setState(() {
      loginUsernameExceptionError = null;
      loginPasswordExceptionError = null;
      _loginProcessing = false;
    });

    if (mounted) {
      if (kDebugMode == false) {
        FirebaseAnalytics.instance.logLogin();
      }
    }
  }

  /// Logs into a Firebase account using a username and password combination.
  ///
  /// Various exceptions can be thrown from the [FirebaseAuth] [signInWithEmailAndPassword] method that indicate
  /// different problems with the login. The codes from these exceptions are used to set the
  /// [loginUsernameExceptionError] and [loginPasswordExceptionError] fields. These show up in the UI the same way
  /// as form validation errors.
  Future<UserCredential?> login({required String emailAddress, required String password}) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);

      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Login failed with exception, $e');

      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loginProcessing) {
      return LoginView(this);
    } else {
      return const LoadingView();
    }
  }

  @override
  void dispose() {
    // Dispose the form controllers.
    usernameFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }
}
