import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/navigable_page_controller.dart';
import 'authentication_route.dart';
import 'authentication_view.dart';

/// Controller for the [AuthenticationRoute].
class AuthenticationController extends NavigablePageController<AuthenticationRoute> {
  /// Signs in the user anonymously, meaning they are not required to enter username/password information or use
  /// an authentication provider like Google.
  static Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      debugPrint('Signed in with temporary account.');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          debugPrint("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          debugPrint('Unknown error.');
      }

      // TODO handle error
    }
  }

  @override
  Widget build(BuildContext context) => AuthenticationView(this);
}
