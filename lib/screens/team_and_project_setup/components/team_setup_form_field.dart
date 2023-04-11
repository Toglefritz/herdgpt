import 'package:flutter/material.dart';

import '../../../values/assets.dart';
import '../../../values/insets.dart';

/// A [TextFormField] used in forms on the authentication pages.

class TeamSetupFormField extends StatefulWidget {
  const TeamSetupFormField({
    super.key,
    required this.initialValue,
    required this.avatar,
    required this.labelText,
    this.maxLength,
    this.onChanged,
    required this.validator,
    this.onSubmit,
    this.additionalError,
  });

  /// The initial value of the text input fields.
  final String initialValue;

  /// An avatar image to display on the left side of the field.
  final Assets avatar;

  /// Text to display as a label for the field.
  final String? labelText;

  /// The maximum allowed length of the input.
  final int? maxLength;

  /// A callback for when the content of the form changes.
  final Function(String)? onChanged;

  /// A function used to validate input to the field.
  final String? Function(String?) validator;

  /// Determines the function to call will be called when the "Enter" key is pressed.
  final Function()? onSubmit;

  /// An additional error to display outside of those returned by the [validator].
  final String? additionalError;

  @override
  State<TeamSetupFormField> createState() => _TeamSetupFormFieldState();
}

class _TeamSetupFormFieldState extends State<TeamSetupFormField> {
  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).primaryColorDark,
        width: 2.0,
      ),
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 36),
          child: TextFormField(
            initialValue: widget.initialValue,
            cursorColor: Theme.of(context).primaryColorDark,
            maxLines: null,
            minLines: 3,
            maxLength: widget.maxLength,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
            decoration: InputDecoration(
              labelText: widget.labelText,
              fillColor: Theme.of(context).primaryColorLight.withOpacity(0.7),
              border: border,
              focusedBorder: border,
              enabledBorder: border,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red[900]!,
                  width: 2.0,
                ),
              ),
              labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
              contentPadding: const EdgeInsets.only(
                top: insetsMedium,
                right: insetsMedium,
                bottom: insetsMedium,
                left: (72 / 2) + insetsMedium,
              ),
              focusColor: Theme.of(context).primaryColor,
              errorText: widget.additionalError,
              errorMaxLines: 2,
              errorStyle: TextStyle(
                color: Colors.red[900],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: widget.onChanged,
            validator: (value) => widget.validator(value),
            onFieldSubmitted: widget.onSubmit != null ? (value) => widget.onSubmit!() : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Image.asset(
            widget.avatar.path,
            width: 72,
          ),
        ),
      ],
    );
  }
}
