import 'package:flutter/material.dart';

import '../values/insets.dart';

/// An [OutlinedButton] with a border in the app's primaryColor. The [onTap] parameter determines the action to
/// perform when the button is tapped.
class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.onTap,
    required this.text,
    this.icon,
    this.fullWidth,
  });

  /// The function to call when the button is tapped.
  final Function() onTap;

  /// The text to display on the button.
  final String text;

  /// A widget, typically an [Icon], displayed to the left of the [text] within the button.
  final Widget? icon;

  /// Determines if the button should expand to will the width of its parent
  final bool? fullWidth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 3.0,
          color: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColorDark,
        ),
        minimumSize: fullWidth == true ? const Size.fromHeight(70) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: insetsLarge,
          vertical: insetsMedium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            Text(
              text.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
