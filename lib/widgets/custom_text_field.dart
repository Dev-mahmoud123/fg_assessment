import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final int? maxLines;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType type;
  final VoidCallback? onTap;

  final String Function(String?) validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.type,
    this.onTap,
    this.prefixIcon,
    this.maxLines,
    this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      controller: controller,
      maxLines: maxLines,
      keyboardType: type,
      onTap: onTap,
      validator: validator,
    );
  }
}
