import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(
    this.label, {
    super.key,
    required this.cont,
    this.validator,
    this.isObscured = false,
  });
  final String label;
  /// Controller for the text field.
  final TextEditingController cont;
  final String? Function(String?)? validator;
  final bool isObscured;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cont,
      obscureText: isObscured,
      decoration: InputDecoration(labelText: label),
      validator: validator,
    );
  }
}
