import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(this.label,{
    super.key,
    required this.controller,
    this.validator,
  });
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
