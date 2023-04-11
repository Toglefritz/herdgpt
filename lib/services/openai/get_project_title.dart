import 'package:flutter/material.dart';

import 'get_chat_completion.dart';
import 'models/chat_message.dart';
import 'models/chat_response.dart';
import 'models/role.dart';
import 'models/speaker.dart';

/// Returns a string that can be used as an identifier for a mock interview session.
Future<String> getProjectTitle(String jobPosting) async {
  String getTitleInstructions = 'Write a title in four words or fewer for a job fitting the posting, "$jobPosting"';
  ChatMessage getTitleMessage = ChatMessage(role: Role.user, content: getTitleInstructions, speaker: Speaker.system);

  ChatResponse titleRequestResponse = await getChatCompletion(
    messages: [getTitleMessage],
    temperature: 1.0,
    speaker: Speaker.system,
  );

  String jobTitle = titleRequestResponse.choices.first.message.content;

  debugPrint('Got title for new conversation: $jobTitle');

  return jobTitle.trim().replaceAll('"', '');
}
