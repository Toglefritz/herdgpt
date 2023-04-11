import 'package:flutter/material.dart';

import '../chat_controller.dart';

/// The [EndDrawer] presents options for the current chat, including assistant personality, temperature setting,
/// token balance management, and other settings.

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
    required this.state,
  });

  final ChatController state;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [],
      ),
    );
  }
}
