import 'package:flutter/material.dart';

import '../../values/insets.dart';

/// A button allowing the user to log out of their account.
class DrawerFooterButton extends StatelessWidget {
  const DrawerFooterButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.text,
  });

  final IconData icon;
  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Padding(
        padding: const EdgeInsets.all(insetsMedium),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      label: Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
          ),
        ],
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
