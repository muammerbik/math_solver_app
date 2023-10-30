import 'package:flutter/material.dart';
import 'package:math_solver_app/app/constants/colors_constants.dart';

class CustomCircleElevatedButton extends StatefulWidget {
  final Function() ConPressed;
  CustomCircleElevatedButton({super.key, required this.ConPressed});

  @override
  State<CustomCircleElevatedButton> createState() =>
      _CustomCircleElevatedButtonState();
}

class _CustomCircleElevatedButtonState
    extends State<CustomCircleElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.ConPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(160),
        ),
        shadowColor: ColorConstants.transparentColor,
      ),
      child: Container(
        width: 94,
        height: 94,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [ColorConstants.purpleW, ColorConstants.purpleColor],
          ),
        ),
      ),
    );
  }
}
