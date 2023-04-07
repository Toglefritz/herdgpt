import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../values/assets.dart';
import 'light_button.dart';

/// A button allowing the user to sign in or create an account with an existing Google account.
class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return LightButton(
      onTap: onTap,
      text: AppLocalizations.of(context).continueWithGoogle,
      icon: Image.asset(
        Assets.googleLogo.path,
        width: 24,
        height: 24,
      ),
      fullWidth: true,
    );
  }
}
