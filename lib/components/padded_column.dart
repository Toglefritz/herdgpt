import 'package:flutter/material.dart';

/// A [Column] in which each widget in the [children] will be interleaved with
/// [Padding] that has vertical spacing of [childrenPadding].
class PaddedColumn extends StatelessWidget {
  const PaddedColumn({
    super.key,
    required this.childrenPadding,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  final double childrenPadding;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

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
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: getPaddedChildren(),
    );
  }
}
