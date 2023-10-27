import 'package:flutter/material.dart';
import 'package:math_solver_app/models/onbording_model.dart';
import 'package:math_solver_app/pages/premium_page.dart';
import 'package:math_solver_app/widgets/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({super.key});

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  int currentIndex = 0;
  PageController _pageController = PageController();
  bool onboardingCompleted = false;

  List<OnbordingModel> onbordingList = [
    OnbordingModel(
        imgPath: 'assets/images/12.png',
        imgPath2: 'assets/images/12.png',
        title: 'Welcome to \nMath Solver',
        description: ''),
    OnbordingModel(
        imgPath: 'assets/images/Component1.png',
        imgPath2: 'assets/images/32.png',
        title: 'Capture',
        description: 'Snap a photo of your \nmath question.'),
    OnbordingModel(
        imgPath: 'assets/images/Component1.png',
        imgPath2: 'assets/images/Frame 13.png',
        title: 'Solve',
        description: 'Our algorithm will solve \nit step-by-step'),
    OnbordingModel(
        imgPath: 'assets/images/Component1.png',
        imgPath2: 'assets/images/Frame 14.png',
        title: 'Learn',
        description: 'Understand the \nproblem-solving process.'),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController = PageController();
    super.dispose();
  }

  void onPageChanged(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  void continueButtonTapped() {
    if (currentIndex == onbordingList.length - 1) {
      markOnboardingCompleted();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const PremiumPage()));
    }
    _pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void markOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completed', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: onPageChanged,
              itemCount: onbordingList.length,
              itemBuilder: (context, index) {
                return buildPage(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: buildContinueButton(),
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }

  Stack buildPage(int index) {
    return Stack(
      children: [
        if (index != 0)
          Image.asset(
            onbordingList[index].imgPath,
            fit: BoxFit.cover,
            width: double.maxFinite,
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  onbordingList[index].imgPath2,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              onbordingList[index].title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              onbordingList[index].description.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            
            if (index != 0) ...[
              const SizedBox(height: 16),
              buildDots(),
              const SizedBox(height: 16),
            ]
          ],
        ),
      ],
    );
  }

  Row buildDots() {
    return Row( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onbordingList.length - 1,
        (index) => Container(
          height: 10,
          width: 10,
          margin:const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: currentIndex == index + 1
                ? Colors.grey
                : const Color(0x2D3C3C43),
          ),
        ),
      ),
    );
  }

  Widget buildContinueButton() {
    return CustomElevatedButton(onPressed: continueButtonTapped, text: 'Continue');
  }
}
