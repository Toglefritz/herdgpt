import 'chat_message.dart';

/// Represents a conversation between the user and the assistant team. Each conversation consists of a [title] used to
/// identify the conversation and a list of [ChatMessage]s in the conversation.
class ChatConversation {
  /// A title used to identify the conversation to the user
  String title;

  /// A list of messages in the conversation.
  List<ChatMessage> messages;

  ChatConversation({
    required this.title,
    required this.messages,
  });

  /// Converts the [ChatConversation] instance to JSON format for use in Firebase API calls.
  Map<String, dynamic> toJson() {
    // Set the title
    Map<String, dynamic> json = {
      'title': title,
    };

    // Assemble the list of conversation messages
    List<Map<String, dynamic>> messagesJson = [];
    for (ChatMessage message in messages) {
      messagesJson.add(message.toJson());
    }

    json['conversations'] = messagesJson;

    return json;
  }
}

/// Returns a list of [ChatConversation]s from data retrieved from Firebase.
List<ChatConversation> conversationListFromData(List<dynamic> data) {
  List<ChatConversation> conversationList = [];

  for (dynamic element in data) {
    ChatConversation conversation = ChatConversation(
      title: element['title'],
      messages: messageListFromData(element['messages']),
    );
    conversationList.add(conversation);
  }

  return conversationList;
}
