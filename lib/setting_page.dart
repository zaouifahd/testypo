import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/controller/GetXSwitchState.dart';
import 'package:browser_project/home_page.dart';
import 'package:browser_project/main.dart';
import 'package:browser_project/privacy_policy_page.dart';
import 'package:browser_project/rating_page.dart';
import 'package:browser_project/services/theme_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  GetXSwitchState getXSwitchState = Get.put(
    GetXSwitchState(),
  );

  InterstitialAd? _interstitialAd;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/home_page", (route) => false);
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_interstitialAd != null) {
          _interstitialAd?.show();
        } else {
          Get.offAll(
            () => HomePage(),
          );
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Settings",
            style: GoogleFonts.urbanist(
              color: (getStorage.read('isDarkMode') == true)
                  ? Colors.white
                  : Colors.black,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: (getStorage.read('isDarkMode') == true)
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () async {
              if (_interstitialAd != null) {
                _interstitialAd?.show();
              } else {
                Get.offAll(
                  () => HomePage(),
                );
              }
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    (getStorage.read('isDarkMode') == true)
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: (getStorage.read('isDarkMode') == true)
                        ? Colors.white
                        : Colors.black87,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Dark Mode",
                    style: GoogleFonts.urbanist(fontSize: 17),
                  ),
                  Spacer(),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                        activeColor: Colors.blue,
                        value: getXSwitchState.isSwitcheded,
                        onChanged: (val) {
                          setState(() {
                            getXSwitchState.changeSwitchState(val);
                            ThemeServices().swichTheme();
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: (getStorage.read('isDarkMode') == true)
                          ? Colors.white
                          : Colors.black87,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Privacy Policy",
                      style: GoogleFonts.urbanist(fontSize: 17),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  Get.to(
                    PolicyPage(
                        name: "Privacy policy",
                        url:
                            privacyPolicyLink),
                  );
                },
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: (getStorage.read('isDarkMode') == true)
                          ? Colors.white
                          : Colors.black87,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Terms & Conditions",
                      style: GoogleFonts.urbanist(fontSize: 17),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  Get.to(
                    PolicyPage(
                        name: "Terms & Condition",
                        url:
                            privacyPolicyLink),
                  );
                },
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.rate_review,
                      color: (getStorage.read('isDarkMode') == true)
                          ? Colors.white
                          : Colors.black87,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Rating App",
                      style: GoogleFonts.urbanist(fontSize: 17),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  String url =
                      AppUrls.playStoreLink;
                  Get.to(
                    RatingPage(),
                    arguments: url,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
