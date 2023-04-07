import 'package:flutter/material.dart';

import '../../components/padded_column.dart';
import '../../values/insets.dart';

/// A page displaying content allowing a user to authenticate an account.
class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({
    super.key,
    required this.content,
  });

  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: SingleChildScrollView(
          child: PaddedColumn(
            childrenPadding: insetsSmall,
            children: content,
          ),
        ),
      ),
    );
  }
}
