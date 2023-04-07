import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herdgpt/components/primary_cta_button.dart';

import '../../components/authentication_form_field.dart';
import '../../components/authentication_page.dart';
import '../../components/padded_column.dart';
import '../../components/sign_in_with_google_button.dart';
import '../../values/insets.dart';
import 'login_controller.dart';

/// View for the [CreateAccountRoute].

class LoginView extends StatelessWidget {
  final LoginController state;

  const LoginView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: AuthenticationPage(
        content: [
          Text(
            AppLocalizations.of(context).welcomeBack,
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
                  additionalError: state.loginUsernameExceptionError,
                ),
                AuthenticationFormField(
                  controller: state.passwordFieldController,
                  labelText: AppLocalizations.of(context).passwordFieldLabel,
                  validator: state.validatePasswordField,
                  obscureText: true,
                  additionalError: state.loginPasswordExceptionError,
                  onSubmit: state.handleBasicAuthLoginSubmit,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: insetsLarge),
                  child: PrimaryCTAButton(
                    onTap: state.handleBasicAuthLoginSubmit,
                    text: AppLocalizations.of(context).loginButtonText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
