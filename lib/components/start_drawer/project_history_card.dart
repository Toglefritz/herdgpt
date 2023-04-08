import 'package:flutter/material.dart';

import '../../values/insets.dart';

/// A [Card] listing the title of a project that the user performed in the past.
class ProjectHistoryCard extends StatelessWidget {
  const ProjectHistoryCard({
    super.key,
    required this.title,
    required this.deleteItemCallback,
  });

  final String title;
  final Function(String) deleteItemCallback;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(insetsMedium),
              child: Icon(Icons.message_outlined),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(insetsSmall),
                child: Text(
                  title,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(insetsSmall),
              child: IconButton(
                onPressed: () => deleteItemCallback(title),
                icon: const Icon(
                  Icons.delete_outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
