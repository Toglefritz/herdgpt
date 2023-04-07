import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'light_button.dart';

/// A button allowing the user to sign in or create an account with an existing Google account.
class SignInAnonymouslyButton extends StatelessWidget {
  const SignInAnonymouslyButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return LightButton(
      onTap: onTap,
      text: AppLocalizations.of(context).signInAnonymously,
      icon: FaIcon(
        FontAwesomeIcons.ghost,
        size: 24,
        color: Theme.of(context).primaryColorDark,
      ),
      fullWidth: true,
    );
  }
}
