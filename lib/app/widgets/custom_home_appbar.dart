import 'package:flutter/material.dart';
import 'package:math_solver_app/app/constants/colors_constants.dart';
import 'package:math_solver_app/app/constants/text_constants.dart';
import 'package:math_solver_app/app/utils/text_utils.dart';

class CustomHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final IconButton newIconButton;
  const CustomHomeAppbar({super.key, required this.newIconButton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: TextUtils.buildTextWidget(
        TextContants.appbarTitle,
        34,
        ColorConstants.blackColor,
        FontWeight.w700,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: newIconButton,
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
