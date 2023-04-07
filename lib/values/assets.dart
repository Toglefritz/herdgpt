/// An enumeration of all the image assets used in the application.
enum Assets {
  cow('cow'),
  aiTeamAssemble('ai_team_assemble'),
  googleLogo('g_logo');

  /// The file path for the image asset.
  final String imagePath;

  /// Creates a new [Assets] instance with the given [imagePath].
  const Assets(this.imagePath);

  /// Returns the [imagePath] prefixed with the directory in which all image assets are stored.
  String get path {
    return 'assets/$imagePath.png';
  }
}