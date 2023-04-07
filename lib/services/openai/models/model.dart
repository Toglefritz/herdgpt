/// Enumerates the chat models available from OpenAI.
enum Model {
  gpt35Turbo('gpt-3.5-turbo'),
  gpt4('gpt-4');

  final String identifier;

  const Model(this.identifier);

  static Model? fromString(String modelString) {
    for (Model model in Model.values) {
      if (model.identifier == modelString) {
        return model;
      }
    }

    return null;
  }
}
