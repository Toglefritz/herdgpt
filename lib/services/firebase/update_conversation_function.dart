import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

/// Updates a conversation in the user's Firestore document with the specified
/// chat conversation data.
///
/// The [chatConversation] parameter is a `ChatConversation` object that contains
/// the title and messages of the conversation to be updated.
///
/// This method uses the Flutter `cloud_functions` plugin to call the
/// `updateConversation` Firebase Cloud Functions callable function and pass
/// in the `chatConversation` data as an argument. The method returns a
/// `Future<void>` that completes when the function call is successful.
///
/// If the function call fails, the method prints a debug message with the
/// error details and rethrows the exception.

Future<void> updateConversationFunction({required String title, required Map<String, dynamic> message}) async {
  final HttpsCallable updateConversation = FirebaseFunctions.instance.httpsCallable('updateConversation');

  try {
    final result = await updateConversation.call(<String, dynamic>{
      'title': title,
      'message': message,
    });

    return result.data;
  } on FirebaseFunctionsException catch (e) {
    debugPrint('updateConversation callable failed with error: ${e.code} - ${e.message}');

    rethrow;
  } catch (e) {
    debugPrint('updateConversation callable failed with error: $e');

    rethrow;
  }
}
