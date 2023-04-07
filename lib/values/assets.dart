/// An enumeration of all the image assets used in the application.
enum Assets {
  aiTeamAssemble('ai_team_assemble'),
  bear('bear'),
  chicken('chicken'),
  cow('cow'),
  fox('fox'),
  goat('goat'),
  googleLogo('g_logo'),
  penguin('penguin'),
  pig('pig'),
  pigeon('pigeon'),
  rabbit('rabbit');

  /// The file path for the image asset.
  final String imagePath;

  /// Creates a new [Assets] instance with the given [imagePath].
  const Assets(this.imagePath);

  /// Returns the [imagePath] prefixed with the directory in which all image assets are stored.
  String get path {
    return 'assets/$imagePath.png';
  }
}