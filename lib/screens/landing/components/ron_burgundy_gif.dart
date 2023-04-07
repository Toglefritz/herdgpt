import 'package:flutter/material.dart';

import '../../../values/gifs.dart';

/// A GIF from the greatest movie ever, Anchorman, inside a container with rounded corners.
class RonBurgundyGif extends StatelessWidget {
  const RonBurgundyGif({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: Image.asset(
          Gifs.aiTeamAssemble.path,
          width: 500,
        ),
      ),
    );
  }
}
