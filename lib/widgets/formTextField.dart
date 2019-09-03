import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter_boilerplate/utils/helpers.dart';
import 'package:flutter/material.dart';

// A custom form text field
class FormTextField extends StatelessWidget {
  const FormTextField({
    @required this.label,
    @required this.controller,
    this.obscureText = false,
    this.marginTop = true,
    this.marginLeft = true,
    this.marginRight = true,
    this.prefixIcon,
    this.keyboardType,
    this.isTextArea = false,
    this.isRequired,
    this.maxLines = 5,
  });

  // The form text field controller
  final TextEditingController controller;
  // The label of the text field
  final String label;
  // Boolean to obscure the text or not (for passwords field)
  final bool obscureText;
  // boolean to add or not a margin top to the text field
  final bool marginTop;
  // boolean to add or not a margin right to the text field
  final bool marginRight;
  // boolean to add or not a margin left to the text field
  final bool marginLeft;
  // Icon to put before the text field label
  final Icon prefixIcon;
  // The keyboard type to show for the field
  final TextInputType keyboardType;
  // Boolean to accept multiple lines
  final bool isTextArea;
  // Boolean to know if the text field is required in the form
  final bool isRequired;
  // The maximum number of lines of the text field
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: marginLeft ? 15 : 0,
        right: marginRight ? 15 : 0,
        top: marginTop ? 15 : 0,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          labelText: label,
          prefixIcon: prefixIcon,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        autofocus: false,
        maxLines: isTextArea ? maxLines : 1,
        validator: (String value) {
          if (value.isEmpty && isRequired == true) {
            return Translations.of(context).text('This field is required');
          } else if (keyboardType == TextInputType.number &&
              value != '' &&
              !isNumeric(value)) {
            return Translations.of(context)
                .text('Please enter a correct number');
          }
          return null;
        },
      ),
    );
  }
}
