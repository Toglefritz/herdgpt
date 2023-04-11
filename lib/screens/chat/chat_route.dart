import '../../components/navigable_page.dart';
import 'chat_controller.dart';
import 'models/conversation_info.dart';

/// Presents the user with options for logging into an existing account or creating a new account.

class ChatRoute extends NavigablePage {
  @override
  String get screenName => '/chat';

  const ChatRoute({
    required this.conversationInfo,
    super.key,
  });

  final ConversationInfo conversationInfo;

  @override
  ChatController createState() => ChatController();
}
