import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  String label;
  TextEditingController controller;
  TextInputType keyboardType;
  bool isPassword;
  InputField(
      {required this.label,
      required this.controller,
      required this.keyboardType,
      this.isPassword = false});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff3C2C20)),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 48,
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xffBA977D), // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10)),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: isHidden
                            ? const Icon(
                                Icons.visibility_off,
                                color: Color(0xffBA977D),
                              )
                            : const Icon(
                                Icons.visibility_rounded,
                                color: Color(0xffBA977D),
                              ),
                        onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                      )
                    : null,
              ),
              obscureText: widget.isPassword && isHidden,
              keyboardType: widget.keyboardType,
            ),
          ),
        ],
      ),
    );
  }
}
