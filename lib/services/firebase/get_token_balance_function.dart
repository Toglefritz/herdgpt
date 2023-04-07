import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

/// Retrieves the token balance for the current user from Firestore.
///
/// This method uses the Flutter `cloud_functions` plugin to call the
/// `getTokenBalance` Firebase Cloud Functions callable function with no
/// arguments. The method returns a `Future<int>` that completes with the
/// value of the `tokenBalance` field in the user's Firestore document.
///
/// If the function call fails, the method prints a debug message with the
/// error details and rethrows the exception.

Future<int> getTokenBalanceFunction() async {
  final HttpsCallable getTokenBalance =
      FirebaseFunctions.instance.httpsCallable('getTokenBalance');

  try {
    final result = await getTokenBalance.call();

    int tokenBalance = result.data['tokenBalance'];

    debugPrint('Retrieved user token balance: $tokenBalance');

    return tokenBalance;
  } on FirebaseFunctionsException catch (e) {
    debugPrint(
        'getTokenBalance callable failed with error: ${e.code} - ${e.message}');

    rethrow;
  } catch (e) {
    debugPrint('getTokenBalance callable failed with error: $e');

    rethrow;
  }
}
