import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:math_solver_app/app/models/mathpix_model.dart';
import 'package:http/http.dart' as http;

class  MathpixApiService {
  final String baseUrl = 'https://api.mathpix.com/v3/text';

  Future<MathPixApiResponse?> sendImageToApi(String url) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'app_id': '********************************************',
        'app_key':
            '*****************************************************',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "src": url,
          "math_inline_delimiters": ["\$", "\$"],
          "rm_spaces": true
        },
      ),
    );
    if (response.statusCode == 200) {
      debugPrint( response.body);
      return MathPixApiResponse.fromJson(response.body);
    }
    
    return null;
  }
  
}
