import 'package:flutter/material.dart';
import 'package:math_solver_app/app/constants/colors_constants.dart';
import 'package:math_solver_app/app/models/settings_model.dart';

class CustomSettingContainer extends StatefulWidget {
  const CustomSettingContainer({super.key});

  @override
  State<CustomSettingContainer> createState() => _CustomSettingContainerState();
}

class _CustomSettingContainerState extends State<CustomSettingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 286,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: ColorConstants.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: settingsList.map((item) {
          return InkWell(
            onTap: () {},
            child: SizedBox(
              width: 113,
              height: 22,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    item.iconPath,
                    width: 20,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    item.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorConstants.blackColor,
                      fontSize: 17,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
