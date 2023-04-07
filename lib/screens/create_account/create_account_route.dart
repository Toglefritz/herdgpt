import '../../../components/navigable_page.dart';
import 'create_account_controller.dart';

/// Presents the user with a form for logging in with a username and password along with options for
/// creating an account using third party authentication providers.
class CreateAccountRoute extends NavigablePage {
  @override
  String get screenName => '/signup';

  const CreateAccountRoute({super.key});

  @override
  CreateAccountController createState() => CreateAccountController();
}
