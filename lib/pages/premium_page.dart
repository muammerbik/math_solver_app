import 'package:flutter/material.dart';
import 'package:math_solver_app/constants/colors_constants.dart';
import 'package:math_solver_app/pages/home_page.dart';
import 'package:math_solver_app/utils/text_utils.dart';
import 'package:math_solver_app/viewmodel/premium_viewmodel.dart';
import 'package:math_solver_app/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  String premium = '';
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
              "Get Premium!",
              30,
              Color(0xFF8151DF),
              FontWeight.w600,
            ),
          ),
          buildRow(),
          buildRow(),
          buildRow(),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 373,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F4FF),
              borderRadius: BorderRadius.circular(0),
            ),
            child: RadioListTile<String>(
                title: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextUtils.buildTextWidget(
                      "Monthly",
                      15,
                      Color(0xFF010101),
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  TextUtils.buildTextWidget(
                    "\$15",
                    18,
                    Color(0xFF010101),
                    FontWeight.w600,
                  ),
                ]),
                value: 'Monthly',
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
              color: const Color(0xFFF8F4FF),
              borderRadius: BorderRadius.circular(0),
            ),
            child: RadioListTile<String>(
                title: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextUtils.buildTextWidget(
                      "Annual",
                      15,
                      Color(0xFF010101),
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  TextUtils.buildTextWidget(
                    " \$30",
                    18,
                    Color(0xFF010101),
                    FontWeight.w600,
                  ),
                ]),
                value: 'Annual',
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

  Padding buildRow() {
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

  CustomElevatedButton buildButton(BuildContext context) {
    return CustomElevatedButton(
        text: 'Start',
        onPressed: () async {
          context.read<PremiumViewModel>().setPremiumComplete().whenComplete(
              () => context.read<PremiumViewModel>().checkPremiumComplate());
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  context.read<PremiumViewModel>().getIsPremium
                      ? const HomePage()
                      : const PremiumPage()));
        });
  }
}
