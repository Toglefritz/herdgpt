import '../../components/navigable_page.dart';
import 'login_controller.dart';

/// Presents the user with a form for logging in with a username and password along with options for
/// creating an account using third party authentication providers.

class LoginRoute extends NavigablePage {
  @override
  String get screenName => '/login';

  const LoginRoute({super.key});

  @override
  LoginController createState() => LoginController();
}
