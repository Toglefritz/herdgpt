import 'package:herdgpt/services/openai/models/speaker.dart';

import 'role.dart';

/// Represents an individual message sent to or from an OpenAI chat model.
///
/// OpenAI offers two types of "completions" endpoints for different language models. With chat-capable models,
/// take a series of messages as input, and return a model-generated message as output. The [ChatMessage]
/// class represents a single one of these messages.
///
/// Each message has a role (either “system”, “user”, or “assistant”), represented by the [Role] enum,  a [Speaker]
/// that identifies the entity that created the message, and content (the content of the message)
class ChatMessage {
  /// The [Role] for this message in the context of the OpenAI API.
  final Role role;

  /// The entity that originated the message.
  final Speaker speaker;

  /// The message itself.
  final String content;

  ChatMessage({
    required this.role,
    required this.speaker,
    required this.content,
  });

  /// Converts the [ChatMessage] to JSON for inclusion in Firebase API calls.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'role': role.identifier,
      'speaker': speaker,
      'content': content,
    };

    return json;
  }

  /// Converts the [ChatMessage] into JSON format for use in REST API cals.
  static List<Map<String, dynamic>> messageListToJson(List<ChatMessage> messages) {
    List<Map<String, dynamic>> json = [];

    for (ChatMessage message in messages) {
      json.add({
        'role': message.role.identifier,
        'speaker': message.speaker,
        'content': message.content,
      });
    }

    return json;
  }
}

/// Returns a list of [ChatMessage]s from data retrieved from Firebase.
List<ChatMessage> messageListFromData(List<dynamic> data) {
  List<ChatMessage> conversationList = [];

  // Loop through the data and convert each element to a ChatMessage
  for (Map<String, dynamic> element in data) {
    ChatMessage conversation = ChatMessage(
      role: Role.fromString(element['role']),
      speaker: element['speaker'],
      content: element['content'],
    );
    conversationList.add(conversation);
  }

  return conversationList;
}
