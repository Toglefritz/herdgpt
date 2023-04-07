import '../../../values/assets.dart';

/// An enumeration of the team members, including both human and AI assistant team members, engaged in a
/// [ChatConversation].
enum Speaker {
  /// Identifies messages originating from the human operator of the app.
  human(Assets.cow),

  bear(Assets.bear),
  chicken(Assets.chicken),
  fox(Assets.fox),
  goat(Assets.goat),
  penguin(Assets.penguin),
  pig(Assets.pig),
  pigeon(Assets.pigeon),
  rabbit(Assets.rabbit),

  /// Identifies messages originating from the app itself. These are not displayed in the UI.
  system(Assets.cow);

  /// The avatar/icon used to identify the [Speaker] visually.
  final Assets avatar;

  const Speaker(this.avatar);
}
