import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppViewModel with ChangeNotifier {
  int premiumRight = 5;


  Future<int> decreasePremiumRight() async {
    final prefs = await SharedPreferences.getInstance();
    var right = await getPremiumRight();
    if (right > 0) {
      right--;
      await prefs.setInt('premiumRight', right);
    }
    premiumRight = right;
    notifyListeners();

    return right;
  }

  Future<int> getPremiumRight() async {
    final prefs = await SharedPreferences.getInstance();
    premiumRight = prefs.getInt('premiumRight') ?? 5;
    notifyListeners();
    return premiumRight;
  }
}
