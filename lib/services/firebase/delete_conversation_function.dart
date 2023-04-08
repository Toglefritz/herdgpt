import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

/// Deletes a conversation in the user's Firestore document with the specified
/// chat conversation data.
///
/// The [chatConversation] parameter is a `ChatConversation` object that contains
/// the title and messages of the conversation to be deleted.
///
/// This method uses the Flutter `cloud_functions` plugin to call the
/// `deleteConversation` Firebase Cloud Functions callable function and pass
/// in the `chatConversation` data as an argument. The method returns a
/// `Future<void>` that completes when the function call is successful.
///
/// If the function call fails, the method prints a debug message with the
/// error details and rethrows the exception.
Future<void> deleteConversation(String title) async {
  final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('deleteConversation');
  try {
    await callable.call(<String, dynamic>{'title': title});
    debugPrint('Conversation deleted successfully');
  } catch (e) {
    debugPrint('Error deleting conversation: $e');

    rethrow;
  }
}
