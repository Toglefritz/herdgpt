import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:herdgpt/screens/landing/components/footer.dart';

import '../../components/app_bar/main_app_bar.dart';
import '../../values/insets.dart';
import 'components/primary_cta_button.dart';
import 'components/ron_burgundy_gif.dart';
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
              const RonBurgundyGif(),
              Text(
                AppLocalizations.of(context).willFerrellCaption,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(insetsLarge),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.handPointRight,
                      size: 42,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: insetsMedium),
                      child: PrimaryCTAButton(
                        onTap: state.letsGoooooooo,
                        text: AppLocalizations.of(context).getStartedButton,
                      ),
                    ),
                    const FaIcon(
                      FontAwesomeIcons.handPointLeft,
                      size: 42,
                    ),
                  ],
                ),
              ),
              // TODO add more product info
            ],
          ),
        ),
      ),
      // Footer
      bottomNavigationBar: const Footer(),
    );
  }
}
