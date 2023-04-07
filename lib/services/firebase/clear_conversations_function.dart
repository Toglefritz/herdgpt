import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

/// This method takes no arguments and uses the FirebaseFunctions class from the cloud_functions package to get
/// a reference to the deleteAllConversations Firebase Cloud Function.
///
/// The method then calls the call method on the FirebaseFunctions instance with no arguments. This sends a request
/// to the Firebase Cloud Function with no arguments.
///
/// If the request is successful, the function prints a success message to the console.
///
/// If there is an error, the function catches the error and prints an error message to the console. If the error
/// is a CloudFunctionsException, the function prints the error message from the exception. If the error is not
/// a CloudFunctionsException, the function prints the error message itself.

Future<void> clearConversations() async {
  final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('clearConversations');
  try {
    await callable.call();
    debugPrint('All conversations deleted successfully');
  } catch (e) {
    debugPrint('Error deleting conversations: $e');

    rethrow;
  }
}
