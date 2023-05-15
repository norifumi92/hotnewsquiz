import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hotnewsquiz/pages/score_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Load MobileAds only for Android/iOS
  if (!kIsWeb) {
    MobileAds.instance.initialize();

    RequestConfiguration configuration = RequestConfiguration(
        testDeviceIds: ["3AC45BF3BACE609A7F26FA203604F81F"]);
    MobileAds.instance.updateRequestConfiguration(configuration);
  }
  runApp(const MyApp());
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
      routes: {
        "/": (context) => HomePage(),
        "/ScorePage": (context) => ScorePage(),
      },
    );
  }
}
