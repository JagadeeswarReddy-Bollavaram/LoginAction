import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;

  const SocialLoginButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 116,
      child: TextButton(
        onPressed: () {
          // Add social login logic
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          side: const BorderSide(
            color: Color(0xffAFA2C3), // Border color
            width: 1.0, // Border width
          ),
        ),
        child: Text(text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xff3E334E),
            )),
      ),
    );
  }
}
