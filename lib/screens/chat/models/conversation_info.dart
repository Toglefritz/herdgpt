import 'package:herdgpt/services/openai/models/chat_conversation.dart';

/// Represents the information necessary to start a new team chat conversation or to continue an existing
/// conversation. This information includes either a description of the AI agent members of the team or a past
/// [ChatConversation], but not both.
class ConversationInfo {
  final String? assistantInformation;
  final ChatConversation? activeConversation;
  final String? projectInformation;

  const ConversationInfo({
    this.assistantInformation,
    this.activeConversation,
    this.projectInformation,
  }) : assert(assistantInformation != null || activeConversation != null,
            'Either assistantInformation or activeInterview must be supplied.');
}
