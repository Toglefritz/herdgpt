import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import 'initialize_remote_configs.dart';

/// Creates a new user document in Firestore for the current user with the
/// specified token balance.
///
/// The [tokenBalance] parameter is the integer value to be used as the token
/// balance in the new user document. The [createdAt] field is sent in to
/// the Firebase Cloud function to set the timestamp that the user account was
/// created.
///
/// This method uses the Flutter `cloud_functions` plugin to call the `createUser`
/// Firebase Cloud Functions callable function and pass in the [tokenBalance]
/// value as an argument. The method returns a `Future<void>` that completes
/// when the function call is successful.
///
/// If the function call fails, the method prints a debug message with the error
/// details and rethrows the exception.

Future<void> createUserFunction() async {
  final HttpsCallable createUser = FirebaseFunctions.instance.httpsCallable('createUser');

  int tokenBalance = RemoteConfigs.initialTokenBalance;

  try {
    final result = await createUser.call(<String, dynamic>{
      'tokenBalance': tokenBalance,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    });

    debugPrint('Successfully created user account. Initial token balance, $tokenBalance');

    return result.data;
  } on FirebaseFunctionsException catch (e) {
    debugPrint('createUser callable failed with error: ${e.code} - ${e.message}');

    rethrow;
  } catch (e) {
    debugPrint('createUser callable failed with error: $e');

    rethrow;
  }
}
