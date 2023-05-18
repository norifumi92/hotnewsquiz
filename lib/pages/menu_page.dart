import 'package:flutter/material.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/components/quiz_item.dart';
import 'package:hotnewsquiz/components/my_drawer.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/models/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  double screenWidth = 0;
  double screenHeight = 0;
  bool startAnimation = false;

  //Define completed quizzes
  List<String> _completedQuizzes = [];

  //Call quiz controller
  final QuizController quizController = Get.put(QuizController());
  List<String>? quizList;

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

    //Load the quizzes already taken from the shared preference of the local device
    _loadCompletedQuizzes();
  }

  void _loadCompletedQuizzes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _completedQuizzes = prefs.getStringList('completedQuizzes') ?? [];
      print(_completedQuizzes);
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
      drawer: const MyDrawer(),
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
                        Quiz quiz = quizController.quizzes[index];
                        //Check if the quiz is already completed
                        bool isCompleted =
                            _completedQuizzes.contains(quiz.quizKey);

                        return QuizItem(
                          index,
                          quiz: quizController.quizzes[index],
                          isCompleted: isCompleted,
                          screenWidth: screenWidth,
                          startAnimation: startAnimation,
                        );
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
          padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
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
}
