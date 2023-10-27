import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:math_solver_app/firebase_options.dart';
import 'package:math_solver_app/models/premium_model.dart';
import 'package:math_solver_app/pages/main_page.dart';
import 'package:math_solver_app/pages/solution_page.dart';
import 'package:math_solver_app/pages/solving_page.dart';
import 'package:math_solver_app/viewmodel/premium_viewmodel.dart';
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
  await Hive.initFlutter();
  Hive.registerAdapter(PremiumModelAdapter());
  await Hive.openBox<PremiumModel>('premium');

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PremiumViewModel()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Math Solver App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF8FF),
        useMaterial3: true,
      ),
      home: const  MainPage(),
    );
  }
}
