import '../../components/navigable_page.dart';
import 'landing_controller.dart';

/// A landing page used to explain and sell the features of **HirePrep** to visitors and includes calls to action
/// that drive visitors into the top of a sales funnel. Also includes supplementary resources such as press kits,
/// resources, legal information, and other assets.

class LandingRoute extends NavigablePage {
  const LandingRoute({super.key});

  @override
  LandingController createState() => LandingController();
}
