import 'package:flutter/material.dart';
import 'package:math_solver_app/app/constants/colors_constants.dart';
import 'package:math_solver_app/app/constants/text_constants.dart';
import 'package:math_solver_app/app/pages/home_page.dart';
import 'package:math_solver_app/app/widgets/custom_row_.dart';
import 'package:math_solver_app/app/utils/text_utils.dart';
import 'package:math_solver_app/app/viewmodel/premium_viewmodel.dart';
import 'package:math_solver_app/app/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});
  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  String? premium = null;
  bool isButtonEnabled = false;

  void onCheckboxChanged(bool value) {
    setState(() {
      isButtonEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: buildStackUsage(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildButton(context),
            ),
            const SizedBox(height: 24)
          ]),
    );
  }

  Stack buildStackUsage(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/Component1.png',
        fit: BoxFit.cover,
        width: double.maxFinite,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 32),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                },
                icon: Image.asset(
                  'assets/icons/icon.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset('assets/images/img8.png',
                  fit: BoxFit.cover, width: 150, height: 119),
            ),
          ),
          Center(
            child: TextUtils.buildTextWidget(
              TextContants.getPremium,
              30,
              ColorConstants.purpleColor,
              FontWeight.w600,
            ),
          ),
          CustomRow(),
          CustomRow(),
          CustomRow(),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 373,
            height: 82,
            decoration: BoxDecoration(
              color: ColorConstants.backgroundColor,
              borderRadius: BorderRadius.circular(0),
            ),
            child: RadioListTile<String>(
                title: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextUtils.buildTextWidget(
                      TextContants.monthly,
                      15,
                      ColorConstants.blackColor,
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  TextUtils.buildTextWidget(
                    "\$15",
                    18,
                    ColorConstants.blackColor,
                    FontWeight.w600,
                  ),
                ]),
                value: TextContants.monthly,
                groupValue: premium,
                onChanged: (value) {
                  setState(() {
                    onCheckboxChanged(true);

                    premium = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing),
          ),
          const SizedBox(height: 16),
          Container(
            width: 373,
            height: 82,
            decoration: BoxDecoration(
              color: ColorConstants.backgroundColor,
              borderRadius: BorderRadius.circular(0),
            ),
            child: RadioListTile<String>(
                title: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextUtils.buildTextWidget(
                      TextContants.annual,
                      15,
                      ColorConstants.blackColor,
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  TextUtils.buildTextWidget(
                    " \$30",
                    18,
                    ColorConstants.blackColor,
                    FontWeight.w600,
                  ),
                ]),
                value: TextContants.annual,
                groupValue: premium,
                onChanged: (value) {
                  setState(() {
                    onCheckboxChanged(true);
                    premium = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ]);
  }

  CustomElevatedButton buildButton(BuildContext context) {
    return CustomElevatedButton(
        text: TextContants.start,
        onPressed: () async {
          if (premium == null) {
            return;
          }

          await context.read<PremiumViewModel>().setPremiumComplete();

          final isPremium =
              await context.read<PremiumViewModel>().checkPremiumComplate();
          if (isPremium) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          }
        });
  }
}
