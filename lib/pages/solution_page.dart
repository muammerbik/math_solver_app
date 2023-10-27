import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_solver_app/constants/app_config.dart';
import 'package:math_solver_app/constants/colors_constants.dart';

import 'package:math_solver_app/pages/home_page.dart';
import 'package:math_solver_app/pages/solving_page.dart';
import 'package:math_solver_app/utils/text_utils.dart';

class SolutionPage extends StatefulWidget {
  const SolutionPage({
    super.key,
  });

  @override
  State<SolutionPage> createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
          },
          icon: Image.asset(
            'assets/icons/BackIcon.png',
            width: 18,
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
        title: TextUtils.buildTextWidget(
          "Solution",
          17,
          ColorConstants.blackColor,
          FontWeight.w600,
        ),
      ),
      body: ListView(
        children: [
          _buildCard(
            'Question',
            content: Math.tex(
              AppConfig.mathExpressionData,
              mathStyle: MathStyle.text,
            ),
          ),
          _buildCard('Solution', text: gptVeri(AppConfig.datas)),
          _buildCard('Solving Steps',
              content: Math.tex(
                AppConfig.datas,
                mathStyle: MathStyle.text,
              ),
              text: AppConfig.datas),
        ],
      ),
    );
  }

  Widget _buildCard(String title, {String? text, Widget? content}) {
    var cardHeight = text == null ? 156.0 : null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: cardHeight,
        decoration: BoxDecoration(
          color: ColorConstants.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorConstants.blackColor,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (text != null || content != null)
                SizedBox(
                  width: double.infinity,
                  child: text != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            text,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      : content,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
