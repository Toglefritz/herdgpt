/// The *finish_reason* field of the OpenAI chat completions response object provides information about the reason
/// why the API finished generating the text completion.
enum FinishReason {
  stop('stop'),
  maxTokens('max_tokens'),
  timeout('timeout'),
  maxTime('max_time'),
  completion('completion'),
  length('length'),
  temperature('temperature'),
  interrupted('interrupted'),
  unknown('unknown');

  final String identifier;

  const FinishReason(this.identifier);

  /// Returns a [ChatRole] from a string based on the [ChatRole] identifiers.
  static FinishReason fromString(String modelString) {
    for (FinishReason reason in FinishReason.values) {
      if (reason.identifier == modelString) {
        return reason;
      }
    }

    return FinishReason.unknown;
  }
}
