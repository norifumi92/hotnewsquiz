import 'package:flutter/material.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/models/quiz.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  double screenWidth = 0;
  double screenHeight = 0;
  bool startAnimation = false;
  bool _isButtonClicked = false;

  //Call quiz controller
  final QuizController quizController = Get.put(QuizController());
  List<String> quizList = [];

  @override
  void initState() {
    super.initState();

    //Load the value from the shared preference of the local device
    _loadButtonClicked();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  void _loadButtonClicked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isButtonClicked = prefs.getBool('isButtonClicked') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple.shade300, Colors.purple.shade900],
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                // Get the list of quizzes in the same mannar that questions are taken
                GetX<QuizController>(
                  init: Get.put<QuizController>(QuizController()),
                  builder: (QuizController quizController) {
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: quizController.quizzes.length,
                      itemBuilder: (context, index) {
                        return item(quizController.quizzes[index], index);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item(Quiz quiz, int index) {
    return AnimatedContainer(
      height: 55,
      width: screenWidth,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 100)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: _isButtonClicked ? Colors.grey.shade300 : Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          TextButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Lottie.asset(
                        'assets/quiz_animation.json', // replace with your own file name
                        width: 300,
                        height: 300,
                      ),
                    );
                  });

              //call shared preference and keep the fact that the button was clicked
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                _isButtonClicked = true;
                prefs.setBool('isButtonClicked', true);
              });

              // Delay execution for 1.5 second before navigating to QuizPage
              Future.delayed(Duration(milliseconds: 1500), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage(quiz)),
                );
              });
            },
            child: NormalText(
              "クイズ(${quiz.quizText})",
              color: Colors.grey.shade700,
            ),
          )
        ],
      ),
    );
  }
}
