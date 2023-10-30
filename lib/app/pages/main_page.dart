import 'package:flutter/material.dart';
import 'package:math_solver_app/app/pages/home_page.dart';
import 'package:math_solver_app/app/pages/onbording_page.dart';
import 'package:math_solver_app/app/pages/premium_page.dart';
import 'package:math_solver_app/app/viewmodel/premium_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool onboardingCompleted = false;
  bool premiumComplate = false;

  Future<void> checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      onboardingCompleted = prefs.getBool('completed') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkOnboardingStatus();
    context.read<PremiumViewModel>().checkPremiumComplate();
  }

  @override
  Widget build(BuildContext context) {
    if(onboardingCompleted== true && context.read<PremiumViewModel>().getIsPremium){
      return const HomePage();
    }else if( onboardingCompleted == true){
 return  const PremiumPage();
    }else{
      return const OnbordingPage();
    }
  }
}
