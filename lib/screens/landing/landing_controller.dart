import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/navigable_page_controller.dart';
import 'landing_route.dart';
import 'landing_view.dart';

/// Controller for the [LandingRoute].

class LandingController extends NavigablePageController<LandingRoute> {
  @override
  String screenName = 'Onboarding';

  @override
  void initState() {
    if (kDebugMode == false) {
      FirebaseAnalytics.instance.logAppOpen();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => LandingView(this);
}
