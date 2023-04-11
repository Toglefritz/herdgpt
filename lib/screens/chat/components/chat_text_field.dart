import 'package:flutter/material.dart';

import '../../../services/openai/models/speaker.dart';
import '../../../values/insets.dart';
import '../chat_controller.dart';

/// A [TextField] used to collect a new message from the user to be used as a prompt for a request to the OpenAI
/// chat completions API.

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.state,
    required this.targetSpeaker,
  });

  final ChatController state;
  final Speaker targetSpeaker;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: state.chatFieldController,
      maxLines: null,
      onChanged: (String message) => state.onChatInputChanged(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).primaryColorLight,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorDark,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorDark,
            width: 1.0,
          ),
        ),
        labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).primaryColorDark,
            ),
        suffixIcon: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => state.onSubmitChatMessage(targetSpeaker),
            child: Icon(
              Icons.send,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.all(insetsMedium),
        focusColor: Theme.of(context).primaryColor,
        errorText: state.chatErrorText,
        errorStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      cursorColor: Theme.of(context).primaryColorDark,
      onSubmitted: (message) => state.onSubmitChatMessage,
    );
  }
}
