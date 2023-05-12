import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdTestPage extends StatefulWidget {
  AdTestPage({super.key});

  @override
  State<AdTestPage> createState() => _AdTestPageState();
}

class _AdTestPageState extends State<AdTestPage> {
  //interstitial ad config
  bool isAdLoaded = false;
  final String interstitialAdUnit =
      "ca-app-pub-3940256099942544/1033173712"; //test ad unit id
  InterstitialAd? _interstitialAd;

  //rewarded ad config
  final String rewardedAdUnit = "ca-app-pub-3940256099942544/5224354917";
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    // initInterstitialAd();
    initRewardedAd();
  }

  //InterstitialAd Init Method
  // initInterstitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: interstitialAdUnit,
  //       request: AdRequest(),
  //       adLoadCallback:
  //           InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
  //         _interstitialAd = ad;
  //       }, onAdFailedToLoad: ((error) {
  //         _interstitialAd = null;
  //         debugPrint(error.message);
  //       })));
  // }

  //RewardedAd Init Method
  void initRewardedAd() {
    RewardedAd.load(
        adUnitId: rewardedAdUnit,
        request: AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _setFullScreenContentCallback();
        }, onAdFailedToLoad: ((error) {
          _rewardedAd = null;
          debugPrint(error.message);
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
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print("$ad onAdFailedToShowFullScreenContent: $error");
        //dispose the dismissed ad
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print("$ad Impression occured"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // if (_interstitialAd != null) {
              //   _interstitialAd!
              //       .show(); // Show the interstitial ad if it's not null
              // } else {
              //   print(
              //       "Interstitial ad not loaded yet"); // Handle the case where the ad is not loaded
              // }

              if (_rewardedAd != null) {
                _rewardedAd!.show(onUserEarnedReward:
                    (AdWithoutView ad, RewardItem rewardItem) {
                  //reward for watching the ad
                  num amount = rewardItem.amount;
                  print("You earned $amount");
                }); // Show the rewarded ad if it's not null
              } else {
                print(
                    "RewardedAd not loaded yet"); // Handle the case where the ad is not loaded
              }
            },
            child: const Text("Task Completed")),
      ),
    );
  }
}
