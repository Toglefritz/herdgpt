import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/navigable_page_controller.dart';
import '../../services/errors/showErrorSnackBar.dart';
import '../../services/firebase/authentication/auth_methods.dart';
import '../../services/firebase/authentication/sign_in_with_google.dart';
import '../../services/firebase/create_user_function.dart';
import '../../values/regex.dart';
import '../loading/loading_view.dart';
import 'create_account_route.dart';
import 'create_account_view.dart';

/// Controller for the [CreateAccountRoute].
class CreateAccountController extends NavigablePageController<CreateAccountRoute> {
  /// A controller for the login form.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// A controller for the username field of the create account form.
  final TextEditingController usernameFieldController = TextEditingController();

  /// A controller for the password field of the create account form.
  final TextEditingController passwordFieldController = TextEditingController();

  /// A controller for the password confirmation field of the create account form.
  final TextEditingController passwordConfirmationFieldController = TextEditingController();

  /// Determines if the username field is in an error state, which is, in turn, determined by the
  /// [validateUsernameField] method.
  bool usernameFieldError = false;

  /// An additional form validation error string set by exceptions thrown during the account creation process related
  /// to the username entry.
  String? createAccountUsernameExceptionError;

  /// An additional form validation error string set by exceptions thrown during the account creation process related
  /// to the password entry.
  String? createAccountPasswordExceptionError;

  /// Determines if the account creation process is in progress
  bool _creatingAccount = false;

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

      // Create the user record in Firebase
      _createUser();
    } catch (e) {
      debugPrint('Failed to sign in with Google with exception, $e');
    }
  }

  /// Validates the username field.
  String? validateUsernameField(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        usernameFieldError = true;
      });

      return 'Oops. Enter a username, please.';
    } else if (!RegEx.emailAddress.hasMatch(value)) {
      setState(() {
        usernameFieldError = true;
      });

      return 'This doesn\'t seem to be a valid email address.';
    }

    setState(() {
      usernameFieldError = false;
    });

    return null;
  }

  /// Validates the password field.
  // This method always returns null because the [validatePasswordConfirmationField] method handles validation
  // for both password field.
  String? validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {});
    } else if (value.length < 6) {
      setState(() {});
    }

    return null;
  }

  /// Validates the password field.
  String? validatePasswordConfirmationField(String? value) {
    if (passwordFieldController.text.isEmpty) {
      return 'Ummm... you\'ll need to enter a password.';
    } else if (passwordFieldController.text.length < 6) {
      return 'A minimum of six characters, please.';
    } else if (value == null || value.isEmpty) {
      return 'Enter the password again here.';
    } else if (value != passwordFieldController.text) {
      return 'The passwords don\'t match. Hate it when that happens...';
    }

    return null;
  }

  /// Creates a password-based account with Firebase Auth.
  ///
  /// As part of creating a password-based account with Firebase Auth, a [FirebaseAuthException] can be thrown if
  /// issues with the provided username or password are discovered.
  Future<UserCredential?> createAccount({required String emailAddress, required String password}) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      debugPrint('Account creation successful. Authenticated with token, ${credential.credential?.token}');

      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException thrown during account creation: $e');

      rethrow;
    } catch (e) {
      debugPrint('Creating password-based account failed with exception, $e');

      rethrow;
    }
  }

  /// Handles submission of the username and password to perform basic authentication against Firebase.
  Future<void> handleCreateAccountSubmit() async {
    setState(() {
      createAccountUsernameExceptionError = null;
      createAccountPasswordExceptionError = null;
      usernameFieldError = false;
      _creatingAccount = true;
    });

    if (formKey.currentState!.validate()) {
      try {
        UserCredential? userCredential = await createAccount(
          emailAddress: usernameFieldController.text,
          password: passwordFieldController.text,
        );

        debugPrint('User, ${userCredential?.user}, successfully authenticated');

        // Create the user record in Firebase
        _createUser();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            createAccountPasswordExceptionError = 'The password provided is too weak.';
            _creatingAccount = false;
          });

          return;
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            usernameFieldError = true;
            createAccountUsernameExceptionError = 'An account already exists using that email.';
            _creatingAccount = false;
          });

          return;
        }
      } catch (e) {
        setState(() {
          createAccountUsernameExceptionError =
              'An unknown error occurred. Not good. Please try again a bit later as this is probably our fault.';
          createAccountPasswordExceptionError =
              'An unknown error occurred. Not good. Please try again a bit later as this is probably our fault.';
          usernameFieldError = true;
          _creatingAccount = false;
        });

        return;
      }

      setState(() {
        createAccountUsernameExceptionError = null;
        createAccountPasswordExceptionError = null;
        usernameFieldError = false;
        _creatingAccount = false;
      });

      if (mounted) {
        if (kDebugMode == false) {
          FirebaseAnalytics.instance.logSignUp(
            signUpMethod: AuthMethods.basicAuth.identifier,
          );
        }
      }
    }
  }

  /// Calls a Firebase Cloud Function that creates a user record in
  /// Firestore.
  Future<void> _createUser() async {
    try {
      await createUserFunction();

      if (!mounted) return;

      // TODO go to team setup route
    } catch (e) {
      showErrorSnackBar(context, AppLocalizations.of(context).errorCreatingAccount);

      debugPrint('Failed to create user with exception, $e');
    }
  }

  /// Handles taps on the Apple sign in button.
  Future<void> handleAppleCreateAccount() async {
    // TODO create account with Apple
  }

  @override
  Widget build(BuildContext context) {
    if (!_creatingAccount) {
      return CreateAccountView(this);
    } else {
      return const LoadingView();
    }
  }

  @override
  void dispose() {
    // Dispose the form controllers.
    usernameFieldController.dispose();
    passwordFieldController.dispose();
    passwordConfirmationFieldController.dispose();
    super.dispose();
  }
}
