import 'package:flutter/material.dart';

import '../../components/navigable_page_controller.dart';
import 'authentication_route.dart';
import 'authentication_view.dart';

/// Controller for the [AuthenticationRoute].
class AuthenticationController extends NavigablePageController<AuthenticationRoute> {
  @override
  Widget build(BuildContext context) => AuthenticationView(this);
}
