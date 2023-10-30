import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_solver_app/app/constants/colors_constants.dart';
import 'package:math_solver_app/app/constants/text_constants.dart';
import 'package:math_solver_app/app/firebase_options.dart';
import 'package:math_solver_app/app/pages/main_page.dart';
import 'package:math_solver_app/app/viewmodel/app_view_model.dart';
import 'package:math_solver_app/app/viewmodel/premium_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PremiumViewModel()),
      ChangeNotifierProvider(create: (_) => AppViewModel()..getPremiumRight()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TextContants.mainTitle,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstants.themeColor,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
