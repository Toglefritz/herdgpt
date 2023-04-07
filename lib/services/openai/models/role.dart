/// Enumerates the roles associated with messages sent to and received from an OpenAI chat model.
///
/// Each message sent to and received from an OpenAI chat model is associated with one of three different roles
/// that represent the source of the message. First, the [system] messages are those used to set up the assistant
/// or to provide "prompt engineering." For example, a conversation session may begin with a system message like
///
///   > You are BlendGPT, a friendly and helpful assistant. Answer as concisely as possible.
///
/// The [user] messages are those created by the app user and entered via the BlendGPT app's UI. In other words,
/// these messages are the equivalent of prompts for other language models.
///
/// Finally, the [assistant] messages are those returned from the model in response to a REST API call to an
/// OpenAI completions endpoint.
enum Role {
  /// Gently instruct the assistant to behave in a particular way.
  system('system'),

  /// Messages from the user, input via the BlendGPT app's UI.
  user('user'),

  /// Messages/completions from the OpenAI chat model.
  assistant('assistant'),

  /// A fallback role in case the role cannot be identified.
  unknown('unknown');

  /// A string identifier for the [Role].
  final String identifier;

  const Role(this.identifier);

  /// Returns a [Role] from a string based on the [Role] identifiers.
  static Role fromString(String modelString) {
    for (Role role in Role.values) {
      if (role.identifier == modelString) {
        return role;
      }
    }

    return Role.unknown;
  }
}
