import 'package:flutter/material.dart';
import 'package:math_solver_app/app/utils/text_utils.dart';

class CustomRow extends StatefulWidget {
  const CustomRow({super.key});

  @override
  State<CustomRow> createState() => _RowUtilsState();
}

class _RowUtilsState extends State<CustomRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/img9.png',
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          TextUtils.buildTextWidget(
            "Lorem Ipsum Dolor Sit",
            16,
            Color(0xFF010101),
            FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
