import 'package:flutter/material.dart';
// import 'start_animation_page.dart';
import 'menu_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Define variable to check the intro button was pressed.
  bool _isIntroButtonClicked = false;

  @override
  void initState() {
    super.initState();
    //Load from the shared preference of the local device _isIntroButtonClicked
    _loadIntroButtonClicked();
  }

  void _loadIntroButtonClicked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('isIntroButtonClicked'));
    setState(() {
      _isIntroButtonClicked = prefs.getBool('isIntroButtonClicked') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple.shade300, Colors.purple.shade900],
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   padding: EdgeInsets.all(8.0),
                //   alignment: Alignment.topLeft,
                //   child: IconButton(
                //     onPressed: () => Navigator.of(context).pop(),
                //     icon: Icon(
                //       CupertinoIcons.xmark,
                //       color: Colors.white,
                //       size: 28,
                //     ),
                //   ),
                // ),
                Text("HOT NEWS QUIZ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    )),
                Text("株価に関わる最新ニュースの知識をテストします。",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    )),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          //builder: (context) => StartAnimationPage()),
                          builder: (context) =>
                              _isIntroButtonClicked ? MenuPage() : IntroPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "START",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                // Text("最新更新日: ${formattedDate}",
                // style: TextStyle(
                //   color: Colors.white,
                //   fontSize: 12,
                // )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
