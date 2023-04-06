import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Classes extending [NavigablePageController] are controllers for navigable pages within the app. Each page is
/// tagged with a Firebase event that allows for tracking of page usage.

abstract class NavigablePageController<T extends StatefulWidget> extends State<T> {
  /// A string identifier for the screen used in logging calls.
  abstract String screenName;

  @override
  void initState() {
    if (kDebugMode == false) {
      FirebaseAnalytics.instance.logScreenView(
        screenClass: widget.runtimeType.toString(),
        screenName: screenName,
      );
    }

    super.initState();
  }
}
