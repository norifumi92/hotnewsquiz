import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/pages/score_page.dart';
import 'package:hotnewsquiz/pages/answer_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HotNewsQuiz',
      theme: ThemeData(
        primaryColor: Colors.black87,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
      ),
      home: HomePage(),
    );
  }
}
