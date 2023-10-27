import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumViewModel with ChangeNotifier {
  bool isPremium = false;

  bool get getIsPremium => isPremium;

  Future<void> setPremiumComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('premiumCompleted', true);
  }

  Future<void> checkPremiumComplate() async {
    final prefs = await SharedPreferences.getInstance();
    isPremium = prefs.getBool('premiumCompleted') ?? false;
    notifyListeners();
  }
}
