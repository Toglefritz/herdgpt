/// An enumeration of all the animated GIF assets used in the application.
enum Gifs {
  aiTeamAssemble('ai_team_assemble.gif');

  /// The file path for the image asset.
  final String gifPath;

  /// Creates a new [Gifs] instance with the given [gifPath].
  const Gifs(this.gifPath);

  /// Returns the [imagePath] prefixed with the directory in which all image assets are stored.
  String get path {
    return 'assets/$gifPath';
  }
}