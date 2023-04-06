import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/assets.dart';
import '../../values/insets.dart';

/// The main [AppBar] appearing at the top of the website for most pages.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 72,
      leading: Padding(
        padding: const EdgeInsets.only(top: insetsMedium, left: insetsLarge),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: insetsSmall),
              child: Image.asset(
                Assets.cow.path,
                width: 56,
              ),
            ),
            Text(
              AppLocalizations.of(context).siteTitle,
              style: GoogleFonts.changaOne().copyWith(
                fontSize: 32,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ],
        ),
      ),
      leadingWidth: 300,
    );
  }
}
