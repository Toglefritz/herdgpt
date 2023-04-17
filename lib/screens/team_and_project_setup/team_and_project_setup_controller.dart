import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herdgpt/extensions/nullable_string_list_extension.dart';
import 'package:herdgpt/screens/chat/models/conversation_info.dart';
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

  /// A list of validation errors to display for each field in the team roles description form.
  List<String?> teamDescriptionFormAdditionalErrors = [null, null];

  /// A validation error to display on the project description field.
  String? projectDescriptionFieldAdditionalError;

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

  /// Adds one more team member to the current team, up to a maximum of eight total members on the team, not
  /// including you, dear human. The function loops through the [_roster] and adds the first benched team member
  /// who is not already on the team.
  void addTeamMember() {
    if (team.length < _roster.length) {
      setState(() {
        for (Speaker agent in _roster) {
          if (!team.contains(agent)) {
            teamDescriptionFormState.add('');
            team.add(agent);
            teamDescriptionFormAdditionalErrors.add(null);
            return;
          }
        }
      });
    }
  }

  /// Removes a team member from the team. We are pretty sure they are not actually killed, just put on the bench. But
  /// you must always have at least two members on the team.
  void removeTeamMember(int index) {
    if (team.length > 2) {
      setState(() {
        teamDescriptionFormState.removeAt(index);
        team.removeAt(index);
        teamDescriptionFormAdditionalErrors.removeAt(index);
      });
    }
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
    setState(() {
      teamDescriptionFormAdditionalErrors.setAllElementsToNull();
    });
  }

  /// A callback for when the contents of the project description field is changed.
  ///
  /// This method is used to save the state of the form whenever the contents are changed.
  void onProjectDescriptionChanged({required String fieldContents}) {
    projectDescriptionFieldState = fieldContents;
    setState(() {
      projectDescriptionFieldAdditionalError = null;
    });
  }

  /// Validates the most recent input into the team member roles fields, stored in the variable,
  /// [teamDescriptionFormState]. This function exists to handle form validation when the team setup fields themselves
  /// are not in the widget tree. Returns null if no validation errors are detected or a String indicating the
  /// error if there are issues in the form.
  List<String?> validateTeamRolesForm() {
    List<String?> errors = [];

    // Check each description in the team role descriptions form
    for(String teamMemberRole in teamDescriptionFormState) {
      String? teamMemberRoleValidation = validateTeamMemberJobField(teamMemberRole);
      if(teamMemberRoleValidation != null) {
        errors.add(teamMemberRoleValidation);
      } else {
        errors.add(null);
      }
    }

    return errors;
  }

  /// Validates the job posting field.
  String? validateTeamMemberJobField(String? value) {
    // TODO add content moderation API

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).teamMemberDescriptionFieldEmpty;
    }

    return null;
  }

  /// Validates the most recent input into the project description field, stored in the variable,
  /// [projectDescriptionFieldState]. This function exists to handle form validation when the project description
  /// field itself is not in the widget tree. Returns null if no validation errors are detected or a String indicating
  /// the error if there are issues in the form.
  String? validateProjectDescriptionForm() {
    return validateProjectDescriptionField(projectDescriptionFieldState);
  }

  /// Validates the job posting field.
  String? validateProjectDescriptionField(String? value) {
    // TODO add content moderation API

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).projectDescriptionFieldEmpty;
    }

    return null;
  }

  /// Handles taps on the CTA button.
  ///
  /// When the CTA button is tapped, this controller will validate the contents of the team member descriptions
  /// form and the project description form based on the validation rules in several other methods in this
  /// controller. If no errors are detected, this method will assemble an instance of [ConversationInfo] and send
  /// that instance to the [ChatRoute] to continue the flow. If validation errors are detected, this method will
  /// set error conditions on the relevant form fields.
  void handleStartButtonTap() {
    List<String?> teamRolesFormValidation = validateTeamRolesForm();
    String? projectDescriptionFormValidation = validateProjectDescriptionForm();

    // Check that no validation errors are detected.
    if (teamRolesFormValidation.areAllElementsNull && projectDescriptionFormValidation == null) {
      ConversationInfo conversationInfo = ConversationInfo(
        assistantInformation: teamDescriptionFormState,
        projectInformation: projectDescriptionFieldState,
      );

      context.go(
        '/chat',
        extra: conversationInfo,
      );
    }
    // Errors were detected in one or both of the forms.
    else {
      setState(() {
        teamDescriptionFormAdditionalErrors = teamRolesFormValidation;
        projectDescriptionFieldAdditionalError = projectDescriptionFormValidation;
      });
    }
  }

  /// Called when a past project is selected from the [Drawer].
  void onPastProjectSelected(ChatConversation conversation) {
    // TODO go to chat route
  }

  @override
  Widget build(BuildContext context) => TeamAndProjectSetupView(this);
}
