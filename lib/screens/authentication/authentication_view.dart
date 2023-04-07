import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herdgpt/screens/create_account/create_account_route.dart';
import 'package:herdgpt/screens/login/login_route.dart';

import '../../components/app_bar/main_app_bar.dart';
import 'authentication_controller.dart';

/// View for the [AuthenticationRoute].
class AuthenticationView extends StatelessWidget {
  final AuthenticationController state;

  const AuthenticationView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MainAppBar(
          displayBackButton: true,
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                icon: Text(
                  AppLocalizations.of(context).createAccount,
                  style: GoogleFonts.changaOne().copyWith(
                    fontSize: 28,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  AppLocalizations.of(context).login,
                  style: GoogleFonts.changaOne().copyWith(
                    fontSize: 28,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CreateAccountRoute(),
            LoginRoute(),
          ],
        ),
      ),
    );
  }
}
