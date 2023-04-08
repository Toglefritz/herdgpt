import 'package:flutter/material.dart';

import '../../values/insets.dart';

/// Shows a [SnackBar] to indicate an error has occurred with an operation conducted by the app. The
/// [SnackBar] consists of an error icon and a [message].
void showErrorSnackBar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: insetsSmall),
          child: Icon(
            Icons.error_outline,
            color: Colors.red[900],
          ),
        ),
        Text(message),
      ],
    ),
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
