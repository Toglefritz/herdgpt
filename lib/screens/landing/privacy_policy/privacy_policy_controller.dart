import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../components/navigable_page_controller.dart';
import 'privacy_policy_route.dart';
import 'privacy_policy_view.dart';

/// Controller for the [HomeRoute].
class PrivacyPolicyController extends NavigablePageController<PrivacyPolicyRoute> {


  /// Handles taps on the [AppBar] back button.
  void onBackPressed() {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) => PrivacyPolicyView(this);
}
