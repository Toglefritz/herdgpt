import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herdgpt/components/app_bar/main_app_bar.dart';
import 'package:herdgpt/components/primary_cta_button.dart';

import '../../components/padded_column.dart';
import '../../values/insets.dart';
import '../../components/start_drawer/start_drawer.dart';
import 'components/team_setup_form_field.dart';
import 'team_setup_controller.dart';

/// View for the [TeamSetupRoute].
class TeamSetupView extends StatelessWidget {
  final TeamSetupController state;

  const TeamSetupView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      drawer: state.user != null
          ? StartDrawer(
              user: state.user!,
              changeProjectCallback: state.onPastProjectSelected,
              deleteItemCallback: state.deletePastConversation,
              deleteAllProjectsCallback: state.deleteAllProjectsCallback,
            )
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: insetsMedium,
            right: insetsLarge,
            bottom: insetsXLarge,
            left: insetsLarge,
          ),
          child: Form(
            key: state.formKey,
            child: PaddedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: insetsSmall,
              children: [
                SelectableText(
                  AppLocalizations.of(context).teamSetupPageTitle,
                  style: GoogleFonts.changaOne().copyWith(
                    fontSize: 36,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: insetsSmall),
                  child: SelectableText(
                    AppLocalizations.of(context).teamSetupPageInstructions,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                ListView.builder(
                  itemCount: state.team.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: insetsSmall),
                          child: Row(
                            children: [
                              SelectableText(
                                AppLocalizations.of(context).enterRoleFor,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              SelectableText(
                                state.team[index].name,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        TeamSetupFormField(
                          avatar: state.team[index].avatar,
                          labelText: null,
                          maxLength: 500,
                          validator: state.validateTeamMemberJobField,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
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
    );
  }
}
