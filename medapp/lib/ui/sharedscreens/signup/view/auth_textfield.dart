import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String text;
  final String label;
  final Widget icon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.text,
    required this.label,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textAlignVertical: TextAlignVertical.center,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label";
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 247, 247, 247),

            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: icon,
            ),

            prefixIconColor: const Color.fromARGB(255, 3, 190, 150),

            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.never,

            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),

            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
