import 'dart:convert';
import 'package:http/http.dart' as http;
//Todo
String gbtUrl = "https://api.openai.com/v1/chat/completions";
Uri url = Uri.parse(gbtUrl);

class GptApiService {
  Future<String> sendQuestionGbt({required String promp}) async {
    http.Response gpttresponse = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            '************************************************',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": promp}
        ]
      }),
    );
    if (gpttresponse.statusCode == 200) {
      var data = jsonDecode(gpttresponse.body);

      data["choices"][0]["message"]["content"];
      return data["choices"][0]["message"]["content"];
    }
    return '';
  }
}
