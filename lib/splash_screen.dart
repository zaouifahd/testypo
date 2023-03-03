import 'dart:async';
import 'package:browser_project/Api_services/Ads_Api/ads_api_controller.dart';
import 'package:browser_project/Api_services/setting_api/setting_api_controller.dart';
import 'package:browser_project/Api_services/topApp_api/topApp_controller.dart';
import 'package:browser_project/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void function() async {
    final ads = Provider.of<AdsAPIProvider>(context, listen: false);
    await ads.getAdsApi();
    final setting = Provider.of<SettingApiProvider>(context, listen: false);
    await setting.settingApi();
    privacyPolicyLink = setting.data["setting"]["privacyPolicyLink"];
    if (ads.data["advertisements"]["googleAd"] == true) {
      bannerAd = ads.data["advertisements"]["banner"];
      rewardAd = ads.data["advertisements"]["reward"];
      nativeAd = ads.data["advertisements"]["native"];
      interstitialAd = ads.data["advertisements"]["interstitial"];
    } else {}
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final ads = Provider.of<AdsAPIProvider>(context, listen: false);
      await ads.getAdsApi();
      if (ads.data["advertisements"]["googleAd"] == true) {
        bannerAd = ads.data["advertisements"]["banner"];
        rewardAd = ads.data["advertisements"]["reward"];
        nativeAd = ads.data["advertisements"]["native"];
        interstitialAd = ads.data["advertisements"]["interstitial"];
      } else {}
    });
    function();
    Timer(const Duration(seconds: 5), () {
      function();
      Get.off(
        () => HomePage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    function();
    final topApp = Provider.of<TopAppProvider>(context, listen: false);
    topApp.topApp();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (getStorage.read('isDarkMode') == true)
                      ? AssetImage("assets/logo/dark logo.png")
                      : AssetImage("assets/logo/light logo.png"),
                ),
              ),
            ),
              AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  WavyAnimatedText(
                    'App Browser',
                    speed: Duration(
                      milliseconds: 270,
                    ),
                    textStyle: GoogleFonts.urbanist(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
