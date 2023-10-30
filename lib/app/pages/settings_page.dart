import 'package:flutter/material.dart';
import 'package:math_solver_app/app/constants/colors_constants.dart';
import 'package:math_solver_app/app/constants/text_constants.dart';

import 'package:math_solver_app/app/utils/text_utils.dart';
import 'package:math_solver_app/app/viewmodel/app_view_model.dart';
import 'package:math_solver_app/app/widgets/custom_setting_container.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
 late int counter = context.read<AppViewModel>().premiumRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/icons/BackIcon.png',
            width: 18,
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 85),
          child: SizedBox(
            child: TextUtils.buildTextWidget(
            TextContants.settings,
              17,
              ColorConstants.blackColor,
              FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: CustomSettingContainer(),
          ),
          Text(
            'number of uses: $counter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
