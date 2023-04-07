import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

/// Updates the token balance for the current user from Firestore.
///
/// This method uses the Flutter `cloud_functions` plugin to call the `updateTokenBalance` Firebase Cloud Functions
/// callable function. As an argument, this method accepts an int value, [tokenBalance], which si the new token
/// balance to apply to the user's account.
///
/// If the function call fails, the method prints a debug message with the
/// error details and rethrows the exception.

Future<void> updateTokenBalanceFunction({required int tokenBalance}) async {
  final HttpsCallable updateTokenBalance = FirebaseFunctions.instance.httpsCallable('updateTokenBalance');

  try {
    final result = await updateTokenBalance.call({'tokenBalance': tokenBalance});

    debugPrint('Updated user token balance to $tokenBalance: ${result.data['message']}');
  } on FirebaseFunctionsException catch (e) {
    debugPrint('getTokenBalance callable failed with error: ${e.code} - ${e.message}');

    rethrow;
  } catch (e) {
    debugPrint('updateTokenBalance callable failed with error: $e');

    rethrow;
  }
}
