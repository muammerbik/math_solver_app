import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_solver_app/constants/app_config.dart';
import 'package:math_solver_app/constants/colors_constants.dart';
import 'package:math_solver_app/pages/home_page.dart';
import 'package:math_solver_app/pages/solution_page.dart';
import 'package:math_solver_app/services/gpt_api_service.dart';
import 'package:math_solver_app/services/mathpix_api._service.dart';
import 'package:math_solver_app/utils/text_utils.dart';

class SolvingPage extends StatefulWidget {
  final String imageUrl;
  const SolvingPage({super.key, required this.imageUrl});

  @override
  State<SolvingPage> createState() => _SolvingPageState();
}

class _SolvingPageState extends State<SolvingPage> {
  final mathpixApiService = MathpixApiService();
  final gbtapiservice = GptApiService();
  String mathExpression = '';

  @override
  void initState() {
    super.initState();
    _postImageToAPI();
  }

  Future<void> _postImageToAPI() async {
    try {
      final mathPixApiResponse =
          await mathpixApiService.sendImageToApi(widget.imageUrl);
      if (mathPixApiResponse != null) {
        setState(() {
          mathExpression = mathPixApiResponse.latexStyled!;
          AppConfig.mathExpressionData = mathExpression;
        });
      }
    } catch (e) {
      debugPrint('API isteği sırasında bir hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 248, right: 26, left: 26),
                  child: Container(
                    width: 338,
                    height: 174,
                    padding: const EdgeInsets.only(
                      top: 49,
                      left: 18,
                      right: 17,
                      bottom: 14,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x213B176A),
                          blurRadius: 38,
                          offset: Offset(0, 22),
                          spreadRadius: -6,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Math.tex(
                                mathExpression,
                                mathStyle: MathStyle.text,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'Solving...',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 22),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 187, right: 140, left: 140),
                  child: Image.asset(
                    'assets/images/animation.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );
          }
          AppConfig.datas = snapshot.data!;
          final gptData = gptVeri(snapshot.data!);
          return Padding(
            padding: const EdgeInsets.only(top: 173, right: 20, left: 20),
            child: Container(
              width: 350,
              height: 350,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 37),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x213B176A),
                    blurRadius: 38,
                    offset: Offset(0, 22),
                    spreadRadius: -6,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextUtils.buildTextWidget(
                      "Solved", 22, ColorConstants.blackColor, FontWeight.w700),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: SizedBox(
                      width: 276,
                      height: 69,
                      child: Math.tex(
                        mathExpression,
                        mathStyle: MathStyle.text,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    gptVeri(snapshot.data!),
                    style: const TextStyle(
                      color: ColorConstants.blackColor,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (gptData == "Solution: Not found") {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SolutionPage(),
                        ));
                      }
                    },
                    child: Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        decoration: BoxDecoration(
                          color: ColorConstants.purpleColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: TextUtils.buildTextWidget(
                            "Show solving steps",
                            17,
                            ColorConstants.backgroundColor,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        future: gbtapiservice.sendQuestionGbt(
            promp:
                "I want you to act like a mathematician. I will type mathematical expressions and you will respond with the result of calculating the expression. I want you to answer step by step. Steps should like be ordered by Step-1, Step-2, Step-3. Give the final solution as Solution: answer but only answer not any explanation. Solution should be only solution but no any words. When I need to tell you something in English, I'll do it by putting the text inside square brackets {like this}. And this expression will be a latex expression. My first expression is: $mathExpression"),
      ),
    );
  }
}

String gptVeri(String text) {
  String formattedString = text;

  List<String> parts = formattedString.split("Solution:");

  String solutionPart =
      parts.length > 1 ? parts[1].trim() : "Solution: Not found";

  debugPrint(solutionPart);
  return solutionPart;
}
