import '../services/firebase/update_token_balance_function.dart';

/// Represents the current user and the information contained within their Firebase user record.
// TODO add OpenAI API integration
class User {
  /// A history of past conversations between the user and the assistant.
  //final List<ChatConversation> conversations;

  /// A [DateTime] for when the user record was created.
  final DateTime createdAt;

  /// The email address for the current user.
  final String emailAddress;

  /// The balance of tokens available on the account.
  int tokenBalance;

  User({
    //required this.conversations,
    required this.createdAt,
    required this.emailAddress,
    required this.tokenBalance,
  });

  /// Creates a [User] instance from the provided JSON data.
  factory User.fromData(Map<String, dynamic> data) {
    List<dynamic> conversationsData = data['conversations'];
    //List<ChatConversation> conversations = conversationListFromData(conversationsData);
    DateTime createdAt = DateTime.parse(data['created_at']);
    String emailAddress = data['email'];
    int tokenBalance = data['token_balance'];

    return User(
      //conversations: conversations,
      createdAt: createdAt,
      emailAddress: emailAddress,
      tokenBalance: tokenBalance,
    );
  }

 /* /// Updates the [conversations] with a new message.
  ///
  /// This method searches through [conversation] to find the [ChatConversation] with the same title as the
  /// provided [activeConversation]. If a [ChatConversation] with a matching title is found, its [messages] value
  /// is replaced with [activeConversation]. Otherwise, [activeConversation] is added to [conversations].
  void updateConversationHistory(ChatConversation activeConversation) {
    Iterable<ChatConversation> targetConversationIterable =
        conversations.where((conversation) => conversation.title == activeConversation.title);

    if (targetConversationIterable.isEmpty) {
      conversations.add(activeConversation);
    } else {
      ChatConversation targetConversation = targetConversationIterable.toList().first;
      targetConversation.messages = activeConversation.messages;
    }
  }*/

  /// Updates the token balance on the [User]'s account.
  ///
  /// Each completion from the OpenAI Chat Completions API is accompanied by a field indicating the number of tokens
  /// used for the completion. This method deducts this number of tokens from the balance on the [User]'s account.
  /// This method
  Future<void> updateTokenBalance(int tokensUsed) async {
    tokenBalance -= tokensUsed;
    await updateTokenBalanceFunction(tokenBalance: tokenBalance - tokensUsed);
  }
}
