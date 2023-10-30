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
        'app_id': 'kv_sharpforksapps_com_797bd6_b5ecc4',
        'app_key':
            '56e83bd220dc8fea9c65d7e4e86c84cb416df984dcb75fd1b560380c80fa17bf',
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
