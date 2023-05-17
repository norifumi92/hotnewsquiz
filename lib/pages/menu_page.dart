import 'package:flutter/material.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:lottie/lottie.dart';
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

  //Call quiz controller
  final QuizController quizController = Get.put(QuizController());
  List<String> quizList = [];

  //scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple.shade800,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _openDrawer,
        ),
      ),
      drawer: Container(
        width: screenWidth * 0.3, // Adjust the width as per your preference
        child: Drawer(
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  //add action
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: const [
                      Icon(Icons.home),
                      SizedBox(width: 10),
                      Text('ホーム'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //add action
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: const [
                      Icon(Icons.email),
                      SizedBox(width: 10),
                      Text('お問合わせ'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //add action
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: const [
                      Icon(Icons.policy),
                      SizedBox(width: 10),
                      Text('規約'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple.shade700, Colors.purple.shade900],
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                const Center(
                    child: NormalText(
                  "クイズリスト",
                  size: 25,
                  isBold: true,
                  color: Colors.white,
                )),
                const Divider(height: 15),
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
      bottomNavigationBar: Container(
          color: Colors.purple.shade900
              .withOpacity(0.9), // Set the desired color and opacity
          padding: EdgeInsets.all(16.0), // Adjust the padding as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.teal),
                ),
                child: Icon(
                  Icons.done,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              const NormalText("受験済"),
              const SizedBox(width: 25),
              Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Icon(
                  Icons.question_mark,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              const NormalText("未受験"),
            ],
          )),
    );
  }

  Widget item(Quiz quiz, int index) {
    return AnimatedContainer(
      height: 50,
      width: screenWidth * 0.8,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 200)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          // color: _isButtonClicked ? Colors.grey.shade300 : Colors.white,
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          GestureDetector(
              onTap: () async {
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
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // setState(() {
                //   _isButtonClicked = true;
                //   prefs.setBool('isButtonClicked', true);
                // });

                //updated picked question list in quizcontroller
                quizController.pickUpQuestions(quiz.quizKey);

                // Delay execution for 1.5 second before navigating to QuizPage
                Future.delayed(Duration(milliseconds: 1200), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage(quiz)),
                  );
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.teal),
                    ),
                    child: Icon(
                      Icons.done,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  NormalText(
                    "クイズ: ${quiz.quizText}のニュースから",
                    size: 20,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
