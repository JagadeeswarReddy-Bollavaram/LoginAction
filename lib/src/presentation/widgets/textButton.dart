import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  ButtonText({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffA03CEA), Color(0xffFB6564)],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
