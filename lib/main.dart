import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HotNewsQuiz',
      theme: ThemeData(
        primaryColor: Colors.black87,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
        accentColor: Colors.white,
      ),
      home: HomePage(),
      // for testing purpose
    );
  }
}
