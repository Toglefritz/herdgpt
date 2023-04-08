import 'package:herdgpt/screens/team_setup/team_setup_controller.dart';

import '../../components/navigable_page.dart';

/// Presents an interface allowing the application to collect the information necessary to set up an assistant for
/// the mock interview session. This information includes a job title, posting, and/or description, a full or
/// summarized resume, and a type of interview. This information is used to create [Role.system] prompts for the
/// assistant and for prompt engineering on subsequent prompts in the mock interview process.

class TeamSetupRoute extends NavigablePage {
  @override
  String get screenName => '/teamsetup';

  const TeamSetupRoute({super.key});

  @override
  TeamSetupController createState() => TeamSetupController();
}
