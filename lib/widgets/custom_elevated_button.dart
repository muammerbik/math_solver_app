import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final Function() onPressed;
  final String text;
  const CustomElevatedButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        backgroundColor: const Color(0xFF8151DF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        child: Center(
          child:
          
           Text(
            widget.text,
            style: const TextStyle(
              color: Color(0xFFFAFAFA),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
