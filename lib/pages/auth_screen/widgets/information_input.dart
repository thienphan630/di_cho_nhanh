import 'package:flutter/material.dart';

class InformationInput extends StatelessWidget {
  const InformationInput({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.labelText,
    required this.validatorText,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String labelText;
  final String validatorText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return validatorText;
          }
          return null;
        },
        onEditingComplete: () {
          FocusManager.instance.primaryFocus!.unfocus();
          formKey.currentState!.validate();
        },
        cursorHeight: 20,
        controller: controller,
        style: const TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 10.0),
            labelText: labelText,
            labelStyle: const TextStyle(fontSize: 16.0),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)))),
      ),
    );
  }
}
