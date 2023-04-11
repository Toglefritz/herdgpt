import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:herdgpt/services/openai/models/speaker.dart';
import '../../components/navigable_page_controller.dart';
import '../../models/user.dart';
import '../../services/errors/show_error_snack_bar.dart';
import '../../services/firebase/clear_conversations_function.dart';
import '../../services/firebase/delete_conversation_function.dart';
import '../../services/firebase/get_user_function.dart';
import '../../services/firebase/update_conversation_function.dart';
import '../../services/openai/get_chat_completion.dart';
import '../../services/openai/get_project_title.dart';
import '../../services/openai/models/chat_conversation.dart';
import '../../services/openai/models/chat_message.dart';
import '../../services/openai/models/chat_response.dart';
import '../../services/openai/models/role.dart';
import '../loading/loading_view.dart';
import '../team_and_project_setup/team_and_project_setup_route.dart';
import 'chat_route.dart';
import 'chat_view.dart';

/// Controller for the [OnboardingRoute].

class ChatController extends NavigablePageController<ChatRoute> {
  /// A [Scaffold] key used to control the [Drawer]s.
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// A controller for the chat text input field into which the user enters message content to submit to the
  /// chat completions endpoint of the OpenAI chat API.
  final TextEditingController chatFieldController = TextEditingController();

  /// A controller for the [SingleChildScrollView] that contains the [ListView] used to display the conversational
  /// thread. The controller is used to automatically scroll to the end of the list whenever a new item is added to it.
  final ScrollController scrollController = ScrollController();

  /// A [User] object representing the current user and their account information including token balance and
  /// chat history.
  Hooman? user;

  /// The purpose of the chat interface is to display an interview between the user and the AI assistant impersonating
  /// an interviewer for a position provided by the user and to add messages to this conversation from both parties
  /// (but not the system). From the menu, the user can select among a list of prior interviews conducted with the
  /// assistant so that those interviews can be continued or reviewed. This field determines the currently-active
  /// interview session.
  ChatConversation activeConversation = ChatConversation(title: 'Project', messages: []);

  /// An error message displayed for the chat input field. If null, no error will be displayed to accompany the
  /// chat input field. If a non-null value is set for this field, the text will be displayed below the chat
  /// input field, typically in a red font color, and the field itself will indicate an error condition.
  String? chatErrorText;

  @override
  initState() {
    if (widget.conversationInfo.activeConversation != null) {
      activeConversation = widget.conversationInfo.activeConversation!;
    }

    // Get the customer's token balance
    _getUser().then((value) => _sendSetupMessage());

    super.initState();
  }

  /// Gets the balance of tokens currently available on the user's account.
  Future<void> _getUser() async {
    Hooman? firebaseUser;

    try {
      firebaseUser = await getUserFunction();
    } catch (e) {
      debugPrint('Failed to get user to start chat with exception, $e');
      // TODO display error in chat
    }

    setState(() {
      user = firebaseUser;
    });
  }

  /// Sends an initial system message to the assistant to start the conversation.
  Future<void> _sendSetupMessage() async {
    // Send the initial message only if the conversation is empty
    if (activeConversation.messages.isEmpty) {
      activeConversation.title = await getProjectTitle(widget.conversationInfo.projectInformation!);

      ChatMessage initialSystemMessage = getInitialChatMessage();
      addChatMessage(initialSystemMessage);
      activeConversation.messages.add(initialSystemMessage);

      ChatResponse initialChatResponse = await getChatCompletion(
        messages: activeConversation.messages,
        temperature: 1.0,
        speaker: Speaker.system,
      );

      addChatMessage(
        ChatMessage(
          role: Role.assistant,
          content: initialChatResponse.choices.first.message.content,
          speaker: Speaker.system,
        ),
      );
    }
  }

  /// Starts a new chat conversation with the assistant.
  void startNewInterview() {
    context.go(const TeamAndProjectSetupRoute().screenName);
  }

  /// Changes the [activeConversation] when a new chat is started or when a past [ChatConversation]
  /// is chosen from the chat history.
  void changeActiveInterview(ChatConversation interview) {
    activeConversation = interview;
  }

  /// Called when the text entry in the chat input changes.
  void onChatInputChanged() {
    setState(() {
      chatErrorText = null;
    });
  }

  /// Handles submissions of the chat message to the OpenAI completions API by validating the chat input and
  /// then, assuming the entry passes validation, calling a function to get a new chat completion. Once the entry
  /// has passed validation, the chat prompt entry field is also cleared to make way for the next message.
  void onSubmitChatMessage(Speaker speaker) {
    String? chatMessage = chatFieldController.text;

    // Validate the chat input
    if (chatMessage.isEmpty) {
      setState(() {
        chatErrorText = 'Enter a message, please.';
      });
    }

    // TODO perform other input validation

    else {
      // Clear the text from the chat field
      chatFieldController.clear();

      _getNewChatCompletion(
        chatMessage: chatMessage,
        speaker: speaker,
      );
    }
  }

  /// Called after the input provided in the chat text field is validated, this method uses the new chat message
  /// in a call to the OpenAI chat completions API to get a new completion. The new completion is added
  /// to the [activeConversation]. When this method is called for the first time, which is indicated by the
  /// [activeConversation.messages] list being empty, an instructional messages is added to the front of the
  /// list.
  Future<void> _getNewChatCompletion({required String chatMessage, required Speaker speaker}) async {
    // Add the new message to the conversation history
    addChatMessage(
      ChatMessage(
        role: Role.user,
        content: chatMessage,
        speaker: Speaker.hooman,
      ),
    );

    // Get a chat completion for the new message
    try {
      ChatResponse chatResponse = await getChatCompletion(
        messages: activeConversation.messages,
        temperature: 1.0,
        speaker: speaker,
      );

      user?.updateTokenBalance(chatResponse.usage?.totalTokens ?? 1000);

      // Add the response to the conversation history
      addChatMessage(
        ChatMessage(
          role: Role.assistant,
          content: chatResponse.choices.first.message.content,
          speaker: speaker,
        ),
      );
    } catch (e) {
      // TODO communicate error in UI

      debugPrint('Failed to get chat completion with exception, $e');
    }
  }

  /// Constructs the initial system message that is used to set up the assistant to impersonate an interviewer for
  /// the job provided by the user.
  ChatMessage getInitialChatMessage() {
    // The system prompt used to set up the assistant
    String systemPromptContent = '';

    String initialPrompt = '';  // TODO write initial prompt

    return ChatMessage(
      role: Role.system,
      content: systemPromptContent,
      speaker: Speaker.system,
    );
  }

  /// Adds a new message to the [activeConversation] and scrolls to the end of the list of messages
  /// in the conversation, the most recent, item.
  void addChatMessage(ChatMessage newMessage) {
    setState(() {
      activeConversation.messages.add(newMessage);

      // Update the conversation history in [widget.user]
      user?.updateConversationHistory(activeConversation);
    });

    // Update the conversation history in Firebase
    updateConversationFunction(
      title: activeConversation.title,
      message: newMessage.toJson(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }

  /// Calls a Firebase callable function to delete the conversation from the user's account and removes the
  /// conversation from the [User] instance, [user].
  Future<void> deletePastConversation(String? title) async {
    if (title != null) {
      try {
        await deleteConversation(title);

        setState(() {
          user?.conversations.removeWhere((element) => element.title == title);
        });
      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context);

        showErrorSnackBar(context, AppLocalizations.of(context).errorDeletingProject);
      }
    }
  }

  /// Calls a Firebase callable function to delete the conversation from the user's account and removes the
  /// conversation from the [User] instance, [user].
  Future<void> deleteAllInterviewsCallback() async {
    try {
      await clearConversations();

      setState(() {
        user?.conversations.clear();
      });
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);

      showErrorSnackBar(context, AppLocalizations.of(context).errorClearingProjects);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const LoadingView();
    } else {
      return ChatView(this);
    }
  }

  @override
  void dispose() {
    chatFieldController.dispose();
    scrollController.dispose();

    super.dispose();
  }
}
