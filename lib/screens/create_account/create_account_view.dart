import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/authentication_form_field.dart';
import '../../components/authentication_page.dart';
import '../../components/padded_column.dart';
import '../../components/primary_cta_button.dart';
import '../../components/sign_in_anonymously_button.dart';
import '../../components/sign_in_with_google_button.dart';
import '../../values/insets.dart';
import '../authentication/authentication_controller.dart';
import 'create_account_controller.dart';

/// View for the [CreateAccountRoute].
class CreateAccountView extends StatelessWidget {
  final CreateAccountController state;

  const CreateAccountView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: AuthenticationPage(
        content: [
          Text(
            AppLocalizations.of(context).createAccountMessage,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SignInWithGoogleButton(
            onTap: state.handleCreateAccountWithGoogle,
          ),
          const Divider(
            thickness: 1.0,
          ),
          Form(
            key: state.formKey,
            child: PaddedColumn(
              childrenPadding: insetsSmall,
              children: [
                AuthenticationFormField(
                  controller: state.usernameFieldController,
                  labelText: AppLocalizations.of(context).usernameFieldLabelHint,
                  validator: state.validateUsernameField,
                  additionalError: state.createAccountUsernameExceptionError,
                ),
                AuthenticationFormField(
                  controller: state.passwordFieldController,
                  labelText: AppLocalizations.of(context).passwordFieldLabel,
                  validator: state.validatePasswordField,
                  obscureText: true,
                  additionalError: state.createAccountPasswordExceptionError,
                ),
                AuthenticationFormField(
                  controller: state.passwordConfirmationFieldController,
                  labelText: AppLocalizations.of(context).passwordConfirmationFieldLabel,
                  validator: state.validatePasswordConfirmationField,
                  obscureText: true,
                  onSubmit: state.handleCreateAccountSubmit,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: insetsLarge),
                  child: PrimaryCTAButton(
                    onTap: state.handleCreateAccountSubmit,
                    text: AppLocalizations.of(context).createAccountButtonText,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.0,
          ),
          SignInAnonymouslyButton(
            onTap: () => AuthenticationController.signInAnonymously(),
          ),
        ],
      ),
    );
  }
}
