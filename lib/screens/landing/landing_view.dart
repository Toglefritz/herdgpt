import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/app_bar/main_app_bar.dart';
import '../../values/gifs.dart';
import '../../values/insets.dart';
import 'landing_controller.dart';

/// View for the [OnboardingRoute].

class LandingView extends StatelessWidget {
  final LandingController state;

  const LandingView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: insetsLarge),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: insetsLarge),
                  child: Text(
                    AppLocalizations.of(context).landingPageTitle,
                    style: GoogleFonts.changaOne().copyWith(
                      fontSize: 42,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
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
              ),
              Text(
                AppLocalizations.of(context).willFerrellCaption,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
