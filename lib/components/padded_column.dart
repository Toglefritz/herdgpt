import 'package:flutter/material.dart';

/// A [Column] in which each widget in the [children] will be interleaved with
/// [Padding] that has vertical spacing of [childrenPadding].
class PaddedColumn extends StatelessWidget {
  const PaddedColumn({
    super.key,
    required this.childrenPadding,
    required this.children,
  });

  final double childrenPadding;
  final List<Widget> children;

  /// Returns a [List<Widget>] in which each widget in the
  List<Widget> getPaddedChildren() {
    List<Widget> paddedWidgets = [];

    Padding padding = Padding(
      padding: EdgeInsets.symmetric(
        vertical: childrenPadding,
      ),
    );

    for (int i = 0; i < children.length; i++) {
      paddedWidgets.add(children[i]);
      paddedWidgets.add(padding);
    }

    return paddedWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: getPaddedChildren(),
    );
  }
}
