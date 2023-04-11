import 'package:flutter/material.dart';

import '../../../services/openai/models/chat_message.dart';
import '../../../services/openai/models/role.dart';
import '../../../values/insets.dart';

/// A [Card] displaying a single message in a conversation with an assistant. Messages from from the "system"
/// role are not displayed. Messages from the "user" role are aligned with a bias towards the right side of the screen
/// while messages from the "assistant" role are biased towards the left.

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: message.role == Role.user && Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).primaryColor
          : Theme.of(context).primaryColorLight,
      margin: EdgeInsets.only(
        top: insetsSmall,
        bottom: insetsSmall,
        right: message.role == Role.user ? insetsSmall : insetsXLarge,
        left: message.role == Role.user ? insetsXLarge : insetsSmall,
      ),
      elevation: message.role == Role.user ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: message.role == Role.user && Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColorDark,
          width: message.role == Role.user && Theme.of(context).brightness == Brightness.dark ? 0.5 : 2.0,
        ),
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        title: Padding(
          padding: const EdgeInsets.all(insetsSmall),
          child: Text(
            message.content,
          ),
        ),
      ),
    );
  }
}
