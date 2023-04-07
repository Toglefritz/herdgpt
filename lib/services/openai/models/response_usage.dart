/// Responses from the OpenAI chat completions API include a "usage" field that contains information
/// about the number of tokens used in different parts of the response.
class ResponseUsage {
  /// A unique identifier for the response.
  final int? promptTokens;

  /// The type of response. For the chat completions API, this value will be "chat.completion".
  final int? completionTokens;

  /// A Unix timestamp for when the response was created.
  final int? totalTokens;

  ResponseUsage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  /// Returns a [ResponseUsage] object from JSON data obtained from a request to the OpenAI chat completions API.
  factory ResponseUsage.fromJson(Map<String, dynamic> json) {
    int? promptTokens = json['prompt_tokens'];
    int? completionTokens = json['completion_tokens'];
    int? totalTokens = json['total_tokens'];

    return ResponseUsage(
      promptTokens: promptTokens,
      completionTokens: completionTokens,
      totalTokens: totalTokens,
    );
  }
}