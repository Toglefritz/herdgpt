import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herdgpt/components/light_button.dart';

import '../../components/padded_column.dart';
import '../../values/insets.dart';
import 'components/team_setup_form_field.dart';
import 'team_and_project_setup_controller.dart';

/// View for the [TeamAndProjectSetupRoute].
class TeamSetupView extends StatelessWidget {
  final TeamAndProjectSetupController state;

  const TeamSetupView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: insetsMedium,
          right: insetsLarge,
          bottom: insetsXLarge,
          left: insetsLarge,
        ),
        child: Form(
          key: state.teamRoleFormKey,
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
                        initialValue: state.teamDescriptionFormState[index],
                        avatar: state.team[index].avatar,
                        labelText: null,
                        maxLength: 500,
                        onChanged: (contents) => state.onTeamDescriptionChanged(
                          fieldContents: contents,
                          index: index,
                        ),
                        validator: state.validateTeamMemberJobField,
                      ),
                    ],
                  );
                },
              ),
              if (state.team.length < 8)
                Padding(
                  padding: const EdgeInsets.only(top: insetsLarge),
                  child: LightButton(
                    onTap: state.addTeamMember,
                    text: AppLocalizations.of(context).addTeamMember,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
