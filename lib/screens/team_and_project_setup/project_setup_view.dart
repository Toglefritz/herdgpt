import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/padded_column.dart';
import '../../values/insets.dart';
import 'components/project_setup_form_field.dart';
import 'team_and_project_setup_controller.dart';

/// View for the [TeamAndProjectSetupRoute].
class ProjectSetupView extends StatelessWidget {
  final TeamAndProjectSetupController state;

  const ProjectSetupView(this.state, {Key? key}) : super(key: key);

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
          key: state.projectFormKey,
          child: PaddedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: insetsSmall,
            children: [
              SelectableText(
                AppLocalizations.of(context).projectSetupPageTitle,
                style: GoogleFonts.changaOne().copyWith(
                  fontSize: 36,
                  color: Theme.of(context).primaryColorDark,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: insetsSmall),
                child: SelectableText(
                  AppLocalizations.of(context).projectSetupPageInstructions,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: insetsSmall),
                  child: Row(
                    children: [
                      SelectableText(
                        AppLocalizations.of(context).describeYour,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SelectableText(
                        AppLocalizations.of(context).amazingProject,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  )),
              ProjectSetupFormField(
                initialValue: state.projectDescriptionFieldState,
                onChanged: (contents) => state.onProjectDescriptionChanged(fieldContents: contents),
                labelText: null,
                maxLength: 500,
                validator: state.validateTeamMemberJobField,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
