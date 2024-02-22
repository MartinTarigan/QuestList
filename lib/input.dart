import 'package:flutter/material.dart';

Widget InputField(
  TextEditingController controller,
  String label,
  bool autoFocus
) {
  String labelText = label;

  return SizedBox(
    height: 77,
    child: TextFormField(
      autofocus: autoFocus,
      controller: controller,
      decoration: InputDecoration(
        fillColor: const Color(0xFFF7F8F9),
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFDADADA)),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal), // Contoh warna
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF8391A1)),
      ),
      validator: (value) => _validateField(value, label),
    ),
  );
}

String? _validateField(String? value, String label) {
  if (value == null || value.isEmpty) {
    return 'Please enter your $label';
  }
  return null;
}
