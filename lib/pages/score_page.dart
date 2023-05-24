import 'package:flutter/material.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/components/go_back_to_menu.dart';
import 'package:hotnewsquiz/components/my_drawer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hotnewsquiz/pages/answer_page.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  //rewarded ad config
  bool isAdLoaded = false;
  final String rewardedAdUnit = "ca-app-pub-3940256099942544/5224354917";
  RewardedAd? _rewardedAd;
  num amount = 0;

  @override
  void initState() {
    super.initState();
    //call RewardedAd load
    if (!kIsWeb) {
      loadRewardedAd();
    }
  }

  @override
  void dispose() {
    try {
      _rewardedAd!.dispose();
    } catch (e) {
      // Exception handling code
      print('Exception caught: $e');
    }
    super.dispose();
  }

  //RewardedAd Load
  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: rewardedAdUnit,
        request: AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          setState(() {
            _rewardedAd = ad;
            isAdLoaded = true; // Set the flag to indicate the ad is loaded
            _setFullScreenContentCallback();
          });
        }, onAdFailedToLoad: ((error) {
          setState(() {
            _rewardedAd = null;
            debugPrint(error.message);
          });
        })));
  }

  void _setFullScreenContentCallback() {
    if (_rewardedAd == null) return;
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print("$ad onShowedFullScreenContent"),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print("$ad onAdDismissedFullScreenContent");
        //dispose the dismissed ad
        ad.dispose();

        //reset the ad
        setState(() {
          _rewardedAd =
              null; // Set the ad reference to null after it's dismissed
          isAdLoaded =
              false; // Set the flag to indicate the ad is no longer loaded
        });
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print("$ad onAdFailedToShowFullScreenContent: $error");
        //dispose the dismissed ad
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print("$ad Impression occured"),
    );
  }

  //scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final quizController = Get.find<QuizController>();

    return WillPopScope(
      onWillPop: () async =>
          false, //With this, the default goback button is deactivated
      child: Scaffold(
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
          child: Align(
            child: Column(
              children: [
                // Container(
                //   padding: const EdgeInsets.only(
                //       top: 10.0, bottom: 3.0, left: 8.0, right: 8.0),
                //   margin: const EdgeInsets.only(top: 30, left: 8.0, right: 8.0),
                //   height: screenHeight * 0.6,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Column(
                //     children: [
                const SizedBox(height: 20),
                const NormalText("テスト結果", size: 25, isBold: true),
                const SizedBox(height: 15),
                Center(
                  child: CircularPercentIndicator(
                    animationDuration: 1000,
                    animation: true,
                    radius: 100,
                    lineWidth: 30,
                    percent: quizController.score /
                        quizController.pickedQuestions.length,
                    progressColor: Colors.teal,
                    backgroundColor: Colors.teal.shade100,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                        "${quizController.score}/${quizController.pickedQuestions.length}",
                        style:
                            const TextStyle(fontSize: 50, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //Show a dialog to notice the user about the rewarded ad in advance
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('動画広告について'),
                                  content: Text(
                                      'Hot News Quizでは動画広告を再生した方のみに解答・解説を提供しています。同意いただける方のみ、「OK」を押して解答へお進みください。'),
                                  actions: [
                                    ElevatedButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          // For mobile, play the ad
                                          if (!kIsWeb) {
                                            if (isAdLoaded) {
                                              _rewardedAd!.show(
                                                  onUserEarnedReward:
                                                      (AdWithoutView ad,
                                                          RewardItem
                                                              rewardItem) {
                                                setState(() {
                                                  //reward for watching the ad
                                                  amount = rewardItem.amount;
                                                });
                                                Get.to(AnswerPage());
                                                ;
                                              }); // Show the rewarded ad if it's not null
                                            } else {
                                              print(
                                                  "RewardedAd not loaded yet"); // Handle the case where the ad is not loaded
                                            }
                                          }
                                          // For browser, skip the ad
                                          else {
                                            Get.to(AnswerPage());
                                          }
                                        }),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      child: const Text('戻る'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const NormalText("解答をチェック"),
                        ),
                        const SizedBox(width: 20),
                        const GoBackToMenuButton(),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // }
}
