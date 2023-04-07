import '../../../components/navigable_page.dart';
import 'authentication_controller.dart';

/// Presents the user with a form for logging in with a username and password along with options for
/// creating an account using third party authentication providers.
class AuthenticationRoute extends NavigablePage {
  @override
  String get screenName => '/letsgoooooooo';

  const AuthenticationRoute({super.key});

  @override
  AuthenticationController createState() => AuthenticationController();
}
