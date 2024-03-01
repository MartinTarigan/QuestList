import 'package:flutter/material.dart';
import 'package:questlist/core/constant/typography.dart';
import 'package:questlist/core/theme/base_color.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final int? maxLines;
  final bool autoFocus;
  final bool readOnly;
  final Function()? onTap;
  final GlobalKey<FormState> formKey;

  const InputField({
    Key? key,
    this.controller,
    required this.label,
    this.maxLines,
    this.autoFocus = false,
    this.readOnly = false,
    this.onTap,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Font.tertiaryBodyLarge,
          ),
          const SizedBox(height: 5),
          SizedBox(
            child: TextFormField(
              controller: controller,
              autofocus: autoFocus,
              maxLines: maxLines,
              readOnly: readOnly,
              onTap: onTap,
              decoration: InputDecoration(
                fillColor: const Color(0xFFF7F8F9),
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDADADA)),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: BaseColors.primaryBlue),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: BaseColors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: BaseColors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: label,
                labelStyle: const TextStyle(color: Color(0xFF8391A1)),
              ),
              validator: (value) => validateField(value, label),
            ),
          ),
        ],
      ),
    );
  }

  String? validateField(String? value, String label) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $label';
    }
    return null;
  }
}
