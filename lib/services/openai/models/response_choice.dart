import 'package:herdgpt/services/openai/models/speaker.dart';

import 'chat_message.dart';
import 'finish_reason.dart';
import 'role.dart';

/// Represents a "choice" of response from the OpenAI chat completions API.
class ResponseChoice {
  /// The entity that originated the message.
  final Speaker speaker;

  /// The index of the response in the list of response choices returned from the OpenAPI API.
  final int index;

  /// The message contents consisting of a [Role] and a string value containing the message itself.
  final ChatMessage message;

  /// A [FinishReason] representing the reason why the OpenAI model stopped generation.
  final FinishReason finishReason;

  ResponseChoice({
    required this.speaker,
    required this.index,
    required this.message,
    required this.finishReason,
  });

  /// Returns a [ResponseChoice] from JSON.
  factory ResponseChoice.fromJson({required Map<String, dynamic> json, required Speaker speaker}) {
    int index = json['index'];
    ChatMessage message = ChatMessage(
      speaker: speaker,
      role: Role.fromString(json['message']['role']),
      content: json['message']['content'],
    );
    FinishReason finishReason = FinishReason.fromString(json['finish_reason']);

    return ResponseChoice(
      speaker: speaker,
      index: index,
      message: message,
      finishReason: finishReason,
    );
  }
}
