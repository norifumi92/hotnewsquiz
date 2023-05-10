import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'menu_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "はじめに...",
            body: "昨今、ソフトウェア・ハードウェア・通信技術・SNS等の進化により、あらゆる手段で情報を得られる時代になりました。",
            image: Lottie.asset(
              'assets/intro_animation_1.json', // replace with your own file name
              width: 400,
              height: 400,
            ),
          ),
          PageViewModel(
            title: "",
            body:
                "投資家は投資のスケール・分野・戦略・期間に関わらず、各々がそれぞれの手段でめまぐるしく変化する世界情勢にアンテナを張り巡らせ意思決定の判断材料にしています。",
            image: Lottie.asset(
              'assets/intro_animation_2.json', // replace with your own file name
              width: 400,
              height: 400,
            ),
          ),
          PageViewModel(
            title: "",
            body:
                "そのような背景を踏まえ、HOT NEWS QUIZでは、プロの投資家が厳選した株価に関する最新ニュースを元にしたクイズを用意し、あなたがどれだけ敏感に最新の情報を仕入れ、理解できているかをテストします。",
            image: Lottie.asset(
              'assets/intro_animation_3.json', // replace with your own file name
              width: 400,
              height: 400,
            ),
          ),
        ],
        showSkipButton: true,
        showNextButton: true,
        skip: const Text("SKIP"),
        next: Icon(Icons.arrow_forward, color: Colors.purple.shade700),
        done: const Text('START'),
        onDone: () {
          navigateToMenuPage(context);
        },
        onSkip: () {
          navigateToMenuPage(context);
        },
      ),
    );
  }

  void navigateToMenuPage(BuildContext context) async {
    //Before navigating to the menu, keep the fact that the user saw this intro in shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isIntroButtonClicked', true);
    print(prefs.getBool('isIntroButtonClicked'));

    //navigate to the menu
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MenuPage(),
      ),
    );
  }
}
