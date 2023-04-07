import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_key.dart';
import 'models/chat_message.dart';
import 'models/chat_request.dart';
import 'models/chat_response.dart';
import 'models/model.dart';
import 'models/speaker.dart';

/// Calls the [_completionsEndpoint] to get a completion for the provided.
///
/// To make a call to the OpenAI chat completions API, a list of previous [ChatMessage]s in the assistant
/// conversation is provided in the [messages] argument, along with a temperature value in the [temperature]
/// argument. This method calls the chat completions endpoint and, assuming the request is successful, returns a
/// [ChatResponse] object. Among other information, the [ChatResponse] object will contain a list of "choices"
/// for responses to the request. The "content" of the first choice is typically used as the chat
/// response from the assistant.
///
/// Documentation for the completions endpoint can be found on the OpenAI documentation site:
/// (https://platform.openai.com/docs/guides/chat) [https://beta.openai.com/docs/api-reference/completions/create].
Future<ChatResponse> getChatCompletion(
    {required Speaker speaker, required List<ChatMessage> messages, required double temperature}) async {
  /// The create chat completion endpoint
  final Uri completionsEndpoint = Uri.parse('https://api.openai.com/v1/chat/completions');

  /// The headers for the completions endpoint, which are the same for all requests
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openAIApiKey',
  };

  // Get a ChatRequest for the chat completion
  ChatRequest request = ChatRequest(
    speaker: speaker,
    model: Model.gpt35Turbo,
    messages: messages,
    user: FirebaseAuth.instance.currentUser?.uid,
    temperature: temperature,
  );

  debugPrint('User: ${messages.last.content}');

  String requestJson = request.toJson();
  http.Response response = await http.post(completionsEndpoint, headers: headers, body: requestJson);

  // Check to see if there was an error
  if (response.statusCode != 200) {
    // TODO handle errors
    debugPrint('Failed to get a chat completion with status code, ${response.statusCode}');

    throw Exception(
        'Received error response from getChatCompletion endpoint: ${response.statusCode}; ${response.body}');
  } else {
    ChatResponse chatResponse = ChatResponse.fromJson(json: jsonDecode(response.body), speaker: speaker);

    debugPrint('Assistant: "${chatResponse.choices[0].message.content}"');

    return chatResponse;
  }
}
