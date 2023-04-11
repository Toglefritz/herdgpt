import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herdgpt/screens/team_and_project_setup/project_setup_view.dart';
import 'package:herdgpt/screens/team_and_project_setup/team_and_project_setup_controller.dart';
import 'package:herdgpt/screens/team_and_project_setup/team_setup_view.dart';

import '../../components/app_bar/main_app_bar.dart';
import '../../components/primary_cta_button.dart';
import '../../values/insets.dart';

/// View for the [AuthenticationRoute].
class TeamAndProjectSetupView extends StatelessWidget {
  final TeamAndProjectSetupController state;

  const TeamAndProjectSetupView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MainAppBar(
          bottom: TabBar(
            //controller: state.tabController,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                icon: Text(
                  AppLocalizations.of(context).teamSetup,
                  style: GoogleFonts.changaOne().copyWith(
                    fontSize: 28,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  AppLocalizations.of(context).projectSetup,
                  style: GoogleFonts.changaOne().copyWith(
                    fontSize: 28,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TeamSetupView(state),
            ProjectSetupView(state),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(insetsLarge),
            child: PrimaryCTAButton(
              onTap: state.handleStartButtonTap,
              text: AppLocalizations.of(context).startChatButtonText,
            ),
          ),
        ),
      ),
    );
  }
}
