import 'package:flutter/material.dart';

import '../../components/padded_column.dart';
import '../../components/start_drawer/start_drawer.dart';
import '../../services/openai/models/chat_message.dart';
import '../../services/openai/models/role.dart';
import '../../services/openai/models/speaker.dart';
import '../../values/insets.dart';
import 'chat_controller.dart';
import 'components/chat_message_card.dart';
import 'components/chat_text_field.dart';
import 'components/end_drawer.dart';

/// View for the [OnboardingRoute].

class ChatView extends StatelessWidget {
  final ChatController state;

  const ChatView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: state.scaffoldKey,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color(0xff2e3139)
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          state.activeConversation.title,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.fact_check_outlined),
            onPressed: () => state.scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      drawer: StartDrawer(
        user: state.user!,
        startNewProjectCallback: state.startNewInterview,
        changeProjectCallback: state.changeActiveInterview,
        deleteItemCallback: state.deletePastConversation,
        deleteAllProjectsCallback: state.deleteAllInterviewsCallback,
      ),
      endDrawer: EndDrawer(
        state: state,
      ),
      body: Padding(
        padding: const EdgeInsets.all(insetsSmall),
        child: PaddedColumn(
          childrenPadding: insetsSmall,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                controller: state.scrollController,
                child: ListView.builder(
                  itemCount: state.activeConversation.messages.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    ChatMessage message = state.activeConversation.messages[index];
                    // Do not display system messages
                    if (message.role == Role.system) {
                      return const SizedBox.shrink();
                    } else {
                      return ChatMessageCard(message: message);
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: insetsSmall),
              child: ChatTextField(
                state: state,
                targetSpeaker: Speaker.pigeon,  // TODO get value from UI
              ),
            ),
          ],
        ),
      ),
    );
  }
}
