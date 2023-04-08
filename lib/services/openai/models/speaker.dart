import '../../../values/assets.dart';

/// An enumeration of the team members, including both human and AI assistant team members, engaged in a
/// [ChatConversation].
enum Speaker {
  /// Identifies messages originating from the human operator of the app.
  hooman(Assets.cow),
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

  /// Returns the user-facing name used for the [Speaker].
  String get name {
    switch (this) {
      case bear:
        return 'Bear';
      case Speaker.hooman:
        return 'You';
      case Speaker.chicken:
        return 'Chicken';
      case Speaker.fox:
        return 'Fox';
      case Speaker.goat:
        return 'Goat';
      case Speaker.penguin:
        return 'Penguin';
      case Speaker.pig:
        return 'Pig';
      case Speaker.pigeon:
        return 'Pigeon';
      case Speaker.rabbit:
        return 'Rabbit';
      case Speaker.system:
        return '';
    }
  }
}
