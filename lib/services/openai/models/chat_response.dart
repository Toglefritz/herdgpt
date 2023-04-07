import 'package:herdgpt/services/openai/models/speaker.dart';

import 'model.dart';
import 'response_choice.dart';
import 'response_usage.dart';

/// Represents a response from a [ChatCompletion] request.
class ChatResponse {
  /// A unique identifier for the response.
  final String id;

  /// The type of response. For the chat completions API, this value will be "chat.completion".
  final String object;

  /// A Unix timestamp for when the response was created.
  final DateTime created;

  /// The OpenAI model used to generate the response. This value is echoed back from the [Model] sent in
  /// the request.
  final Model? model;

  /// A [ResponseUsage] object, which represents the number of tokens used for different parts of the request.
  final ResponseUsage? usage;

  /// A list of messages returned by the chat completions request. Typically, only one choice is requested or
  /// only the first is used, but for different purposes, several choices can be returned.
  final List<ResponseChoice> choices;

  ChatResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.usage,
    required this.choices,
  });

  /// Returns a [ChatResponse] object from JSON data obtained from a request to the OpenAI chat completions API.
  factory ChatResponse.fromJson({required Map<String, dynamic> json, required Speaker speaker}) {
    String id = json['id'];
    String object = json['object'];
    DateTime created = DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000);
    Model? model = Model.fromString(json['model']);
    ResponseUsage usage = ResponseUsage.fromJson(json['usage']);

    List<ResponseChoice> choices = [];
    List<dynamic> choicesJson = json['choices'];
    for (dynamic element in choicesJson) {
      if (element is Map<String, dynamic>) {
        choices.add(ResponseChoice.fromJson(json: element, speaker: speaker));
      }
    }

    return ChatResponse(
      id: id,
      object: object,
      created: created,
      model: model,
      usage: usage,
      choices: choices,
    );
  }
}
