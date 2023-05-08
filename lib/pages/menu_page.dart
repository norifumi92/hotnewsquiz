import 'package:flutter/material.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:lottie/lottie.dart';
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
  bool _isButtonClicked = false;
  List<String> menuList = ["今週のクイズ1"];

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
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: menuList.length,
                    itemBuilder: (context, index) {
                      return item(index);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item(int index) {
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
                        width: 200,
                        height: 200,
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
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              });
            },
            child: NormalText(
              menuList[index],
              color: Colors.grey.shade700,
            ),
          )
        ],
      ),
    );
  }
}
