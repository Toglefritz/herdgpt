import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import 'create_user_function.dart';

/// Retrieves the record for the current user from Firestore.
///
/// This method uses the Flutter `cloud_functions` plugin to call the
/// `getUser` Firebase Cloud Functions callable function with no
/// arguments. The method returns a `Future<User>` that completes with the
/// initialization of a [User] object from the contents of the Firebase
/// file for the current user.
///
/// If the function call fails, the method prints a debug message with the
/// error details and rethrows the exception.
Future<User> getUserFunction() async {
  final HttpsCallable getTokenBalance = FirebaseFunctions.instance.httpsCallable('getUser');

  try {
    final result = await getTokenBalance.call();

    User user = User.fromData(result.data);

    debugPrint('Retrieved user data');

    return user;
  } on FirebaseFunctionsException catch (e) {
    debugPrint('getUser callable failed with error: ${e.code} - ${e.message}');

    if (e.code == 'not-found') {
      debugPrint('Attempting to create user document');
      
      try {
        await createUserFunction();

        return getUserFunction();
      } catch (e) {
        rethrow;
      }
    } else {
      rethrow;
    }
  } catch (e) {
    debugPrint('getUser callable failed with error: $e');

    rethrow;
  }
}
