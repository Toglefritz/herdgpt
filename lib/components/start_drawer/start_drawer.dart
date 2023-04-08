import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user.dart';
import '../../services/firebase/authentication/sign_out.dart';
import '../../services/openai/models/chat_conversation.dart';
import '../light_button.dart';
import '../../values/insets.dart';
import 'project_history_card.dart';
import 'drawer_footer_button.dart';

/// The [ChatStartDrawer] presents the chat history for the current user, a button used to start a new chat,
/// links for app and account settings, and other information related to the account or global system management.

class StartDrawer extends StatelessWidget {
  const StartDrawer({
    super.key,
    required this.user,
    this.startNewProjectCallback,
    required this.changeProjectCallback,
    required this.deleteItemCallback,
    required this.deleteAllProjectsCallback,
  });

  /// The currently authenticated [Hooman].
  final Hooman user;

  /// Called in response to taps on the new project button. If null, the new project button will be hidden.
  final Function()? startNewProjectCallback;

  /// Called in response to taps on the past project items.
  final Function(ChatConversation) changeProjectCallback;

  /// Called in response to taps on the delete project icon.
  final Function(String) deleteItemCallback;

  /// Called in response to taps on the delete all projects button.
  final Function() deleteAllProjectsCallback;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                if (startNewProjectCallback != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: insetsLarge,
                      right: insetsMedium,
                      bottom: insetsLarge,
                      left: insetsMedium,
                    ),
                    child: LightButton(
                      onTap: startNewProjectCallback!,
                      text: AppLocalizations.of(context).newProjectButtonText,
                      fullWidth: true,
                    ),
                  ),
                if (user.conversations.isNotEmpty == true)
                  Padding(
                    padding: EdgeInsets.only(
                      top: startNewProjectCallback != null ? 0 : insetsLarge,
                    ),
                    child: Text(
                      AppLocalizations.of(context).pastProjectsLabel.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (user.conversations.isEmpty == true)
                  Padding(
                    padding: EdgeInsets.only(
                      top: startNewProjectCallback != null ? 0 : insetsLarge,
                    ),
                    child: Text(
                      AppLocalizations.of(context).pastProjectsEmptyExplainer,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ListView.builder(
                  itemCount: user.conversations.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => changeProjectCallback(user.conversations[index]),
                      child: ProjectHistoryCard(
                        deleteItemCallback: deleteItemCallback,
                        title: user.conversations[index].title,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).tokenBalance,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: insetsSmall,
                ),
                child: Opacity(
                  opacity: 0.6,
                  child: Tooltip(
                    message: AppLocalizations.of(context).tokenBalanceExplainer,
                    padding: const EdgeInsets.all(insetsSmall),
                    preferBelow: false,
                    triggerMode: TooltipTriggerMode.tap,
                    child: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).primaryColorDark,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: insetsSmall),
            child: Text(
              user.tokenBalance.toString(),
              style: GoogleFonts.cutiveMono().copyWith(
                fontSize: 28,
              ),
            ),
          ),
          const Divider(
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: insetsLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.conversations.isNotEmpty == true)
                  DrawerFooterButton(
                    icon: Icons.delete_outline,
                    onTap: () => deleteAllProjectsCallback(),
                    text: AppLocalizations.of(context).clearProjects,
                  ),
                DrawerFooterButton(
                  icon: Icons.logout,
                  onTap: () => signOut(),
                  text: AppLocalizations.of(context).logOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
