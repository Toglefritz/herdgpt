import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:herdgpt/screens/team_and_project_setup/team_and_project_setup_view.dart';

import '../../components/navigable_page_controller.dart';
import '../../models/user.dart';
import '../../services/errors/show_error_snack_bar.dart';
import '../../services/firebase/clear_conversations_function.dart';
import '../../services/firebase/delete_conversation_function.dart';
import '../../services/firebase/get_user_function.dart';
import '../../services/openai/models/chat_conversation.dart';
import '../../services/openai/models/speaker.dart';
import 'team_and_project_setup_route.dart';

/// Controller for the [TeamAndProjectSetupRoute].
// TODO add ability to add more agents
class TeamAndProjectSetupController extends NavigablePageController<TeamAndProjectSetupRoute> {
  /// A [Scaffold] key used to control the [Drawer]s.
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// A [Hooman] object representing the current user and their account information including token balance and
  /// chat history.
  Hooman? user;

  /// A roster of all available AI agents from which the user can choose to assemble their team. A team consists of at
  /// least two AI assistants and can have a maximum of
  final List<Speaker> _roster = Speaker.values.toList();

  /// A list of AI agents with which the [user] will collaborate on a problem.
  List<Speaker> team = [];

  /// A key used for the team role description form.
  final GlobalKey<FormState> teamRoleFormKey = GlobalKey<FormState>();

  /// A key used for the project description form.
  final GlobalKey<FormState> projectFormKey = GlobalKey<FormState>();

  /// The contents of the team setup fields, used to save the state of the form when the form transitions on and
  /// off stage.
  List<String> teamDescriptionFormState = ['', ''];

  /// The contents of the project description field, used to save the state of the field when it transitions on and
  /// off stage.
  String projectDescriptionFieldState = '';

  @override
  void initState() {
    if (kDebugMode == false) {
      FirebaseAnalytics.instance.logScreenView();
    }

    // Generate the roster
    _generateRoster();

    // Add the first two members of the team to the list.
    _addInitialTeamMembers();

    // Get user information
    _getUser();

    super.initState();
  }

  /// Generates a roster of available agents by shuffling the list of [Speaker]s into a random order. When AI agents
  /// are added to the team, they will be pulled from this list. The end effect of this approach is that the team
  /// members will be randomized for each new project setup.
  void _generateRoster() {
    _roster.removeWhere((speaker) => speaker == Speaker.system || speaker == Speaker.hooman);

    Random random = Random();
    int n = _roster.length;

    for (int i = n - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      _swap(_roster, i, j);
    }
  }

  /// Swaps the positions of two elements in a list. In this implementation, the list elements are always of the
  /// type, [Speaker].
  void _swap(List<Speaker> list, int i, int j) {
    var temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }

  /// A team must have at least two AI assistants. Including the human user, this makes the minimum team size three.
  /// Using only one assistant on the team would just make this software the same as ChatGPT, a one on one
  /// conversation between the user and the assistant. And we're not doing that because we're a couple hundred million
  /// dollars short of being able to directly compete with OpenAI.
  void _addInitialTeamMembers() {
    team.add(_roster[0]);
    team.add(_roster[1]);
  }

  /// Gets the balance of tokens currently available on the user's account.
  Future<void> _getUser() async {
    Hooman? firebaseUser;
    try {
      firebaseUser = await getUserFunction();
    } catch (e) {
      debugPrint('Failed to get user to start project setup with exception, $e');
      // TODO show error screen
    }

    setState(() {
      user = firebaseUser;
    });
  }

  /// Calls a Firebase callable function to delete the conversation from the user's account and removes the
  /// conversation from the [Hooman] instance, [user].
  Future<void> deletePastConversation(String? title) async {
    if (title != null) {
      try {
        await deleteConversation(title);

        setState(() {
          user?.conversations.removeWhere((element) => element.title == title);
        });
      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context);

        showErrorSnackBar(context, AppLocalizations.of(context).errorDeletingProject);
      }
    }
  }

  /// Calls a Firebase callable function to delete the conversation from the user's account and removes the
  /// conversation from the [Hooman] instance, [user].
  Future<void> deleteAllProjectsCallback() async {
    try {
      await clearConversations();

      setState(() {
        user?.conversations.clear();
      });
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);

      showErrorSnackBar(context, AppLocalizations.of(context).errorClearingProjects);
    }
  }

  /// A callback for when the contents of any of the fields in the team setup form are changed.
  ///
  /// This method is used to save the state of the team setup form whenever the contents of that form is changed.
  void onTeamDescriptionChanged({required String fieldContents, required int index}) {
    teamDescriptionFormState[index] = fieldContents;
  }

  /// A callback for when the contents of the project description field is changed.
  ///
  /// This method is used to save the state of the form whenever the contents are changed.
  void onProjectDescriptionChanged({required String fieldContents}) {
    projectDescriptionFieldState = fieldContents;
  }

  /// Validates the job posting field.
  String? validateTeamMemberJobField(String? value) {
    // TODO add content moderation API

    if (value == null || value.isEmpty) {
      return 'Um... please tell this agent what to do.';
    }

    return null;
  }

  /// Handles taps on the CTA button.
  void handleStartButtonTap() {
    if (teamRoleFormKey.currentState!.validate() && projectFormKey.currentState!.validate()) {
      // TODO go to chat route
    }
  }

  /// Called when a past project is selected from the [Drawer].
  void onPastProjectSelected(ChatConversation conversation) {
    // TODO go to chat route
  }

  @override
  Widget build(BuildContext context) => TeamAndProjectSetupView(this);
}
