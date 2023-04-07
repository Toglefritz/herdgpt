import 'package:flutter/material.dart';

import '../values/insets.dart';

/// A [TextFormField] used in forms on the authentication pages.

class AuthenticationFormField extends StatefulWidget {
  const AuthenticationFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.multiline,
    this.maxLength,
    this.onChanged,
    required this.validator,
    this.onSubmit,
    this.obscureText,
    this.additionalError,
  });

  /// A controller for the field.
  final TextEditingController controller;

  /// Text to display as a label for the field.
  final String? labelText;

  /// Determines if this field accepts multiple lines of text as its input.
  final bool? multiline;

  /// The maximum allowed length of the input.
  final int? maxLength;

  /// A callback for when the contents of the text field changes.
  final Function(String)? onChanged;

  /// A function used to validate input to the field.
  final String? Function(String?) validator;

  /// Determines the function to call will be called when the "Enter" key is pressed.
  final Function()? onSubmit;

  /// Determines if the input text should be obscured
  final bool? obscureText;

  /// An additional error to display outside of those returned by the [validator].
  final String? additionalError;

  @override
  State<AuthenticationFormField> createState() => _AuthenticationFormFieldState();
}

class _AuthenticationFormFieldState extends State<AuthenticationFormField> {
  /// Determines whether, for a field with [widget.obscureText] set to true, the text should be displayed
  /// anyway, based on a user's actions. If true, the text is displayed regardless of whether [widget.obscureText] is
  /// true, false, or null.
  bool _obscureTextOverride = false;

  /// Toggles the [_obscureTextOverride] boolean on and off.
  void toggleVisibility() {
    setState(() {
      _obscureTextOverride = !_obscureTextOverride;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText == true && _obscureTextOverride != true,
      cursorColor: Theme.of(context).primaryColorDark,
      onChanged: widget.onChanged,
      maxLines: widget.multiline == true ? null : 1,
      minLines: widget.multiline == true ? 3 : null,
      maxLength: widget.maxLength,
      style: TextStyle(
        color: Theme.of(context).primaryColorDark,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        fillColor: Theme.of(context).primaryColorLight.withOpacity(0.7),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorDark,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorDark,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorDark,
            width: 2.0,
          ),
        ),
        labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).primaryColorDark,
            ),
        suffixIcon: widget.obscureText == true
            ? GestureDetector(
                onTap: toggleVisibility,
                child: Icon(
                  _obscureTextOverride == true ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.8),
                ),
              )
            : null,
        contentPadding: const EdgeInsets.all(insetsMedium),
        focusColor: Theme.of(context).primaryColor,
        errorText: widget.additionalError,
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      validator: (value) => widget.validator(value),
      onFieldSubmitted: widget.onSubmit != null ? (value) => widget.onSubmit!() : null,
    );
  }
}
