import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int maxLength;
  final void Function(String?) onFieldSubmitted;
  const FormInput({
    super.key,
    required this.labelText,
    this.hintText = '',
    required this.focusNode,
    required this.keyboardType,
    required this.controller,
    this.maxLength = 64,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        focusNode: focusNode,
        keyboardType: keyboardType,
        controller: controller,
        maxLength: maxLength,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
