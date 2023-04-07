import 'dart:convert';

import 'package:herdgpt/services/openai/models/speaker.dart';

import 'chat_message.dart';
import 'model.dart';

/// Represents a request to the OpenAI chat completions API.
///
/// Chat models take a series of messages as input, and return a model-generated message as output. The
/// [ChatRequest] class represents a request to a an OpenAI chat model. These requests are sent via the OpenAI
/// REST APIs.
class ChatRequest {
  /// The entity that originated the message.
  final Speaker speaker;

  /// The [Model] to use for the completion.
  final Model model;

  /// A list of [ChatMessage]s for either the entire conversation history or, depending upon use case, a
  /// subsection of the conversation history. Note that the limit for the total combined length of all
  /// [messages] is 4090 tokens.
  final List<ChatMessage> messages;

  /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
  final String? user;

  /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random,
  /// while lower values like 0.2 will make it more focused and deterministic.
  ///
  /// Defaults to 1.
  final double? temperature;

  /// How many chat completion choices to generate for each input message.
  ///
  /// Defaults to 1.
  final int? n;

  /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results
  /// of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability
  /// mass are considered.
  ///
  /// Defaults to 1.
  final int? topP;

  /// If set, partial message deltas will be sent, like in ChatGPT. Tokens will be sent as data-only server-sent
  /// events as they become available, with the stream terminated by a data: *DONE*.
  ///
  /// Defaults to false.
  final bool? stream;

  /// Up to 4 sequences where the API will stop generating further tokens.
  ///
  /// Defaults to null.
  final List<String>? stop;

  /// The maximum number of tokens allowed for the generated answer. By default, the number of tokens the model can
  /// return will be (4096 - prompt tokens).
  ///
  /// Defaults to inf.
  final int? maxTokens;

  /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so
  /// far, increasing the model's likelihood to talk about new topics.
  ///
  /// Defaults to 0.
  final double? presencePenalty;

  /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text
  /// so far, decreasing the model's likelihood to repeat the same line verbatim.
  ///
  /// Defaults to 0.
  final double? frequencyPenalty;

  ChatRequest({
    required this.speaker,
    required this.model,
    required this.messages,
    required this.user,
    this.temperature,
    this.topP,
    this.n,
    this.stream,
    this.stop,
    this.maxTokens,
    this.presencePenalty,
    this.frequencyPenalty,
  })  : assert(messages.isNotEmpty, 'At least one message must be provided'),
        assert(
            temperature == null || (0 <= temperature && temperature <= 2), 'The temperature must be between 1 and 2'),
        assert(!(temperature != null && topP != null), 'Either the temperature or topP can be defined, not both.');

  /// Converts the [ChatRequest] into JSON format for use in REST API cals.
  String toJson() {
    Map<String, dynamic> jsonBody = {
      'model': model.identifier,
      'messages': ChatMessage.messageListToJson(messages),
      'user': user,
    };

    if (temperature != null) {
      jsonBody.addAll({'temperature': temperature});
    }

    if (topP != null) {
      jsonBody.addAll({'top_p': topP});
    }

    if (n != null) {
      jsonBody.addAll({'n': n});
    }

    if (stream != null) {
      jsonBody.addAll({'stream': stream});
    }

    if (maxTokens != null) {
      jsonBody.addAll({'max_tokens': maxTokens});
    }

    if (presencePenalty != null) {
      jsonBody.addAll({'presence_penalty': presencePenalty});
    }

    if (stop != null) {
      jsonBody.addAll({'stop': stop});
    }

    if (maxTokens != null) {
      jsonBody.addAll({'max_tokens': maxTokens});
    }

    if (presencePenalty != null) {
      jsonBody.addAll({'presence_penalty': presencePenalty});
    }

    if (frequencyPenalty != null) {
      jsonBody.addAll({'frequency_penalty': frequencyPenalty});
    }

    return json.encode(jsonBody);
  }
}
