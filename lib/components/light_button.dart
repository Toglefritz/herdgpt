import 'package:flutter/material.dart';

import '../values/insets.dart';

/// An [ElevatedButton] with a background color that opposes the [Scaffold] background color. The [onTap] parameter
/// determines the action to perform when the button is tapped.
class LightButton extends StatelessWidget {
  const LightButton({
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
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).primaryColorLight
            : Theme.of(context).primaryColorDark,
        minimumSize: fullWidth == true ? const Size.fromHeight(60) : null,
        side: BorderSide(
          width: 2.0,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: insetsLarge,
          vertical: insetsMedium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: insetsMedium),
                child: icon!,
              ),
            Text(
              text.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
