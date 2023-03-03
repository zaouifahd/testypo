// ignore_for_file: must_be_immutable
import 'package:browser_project/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyPage extends StatefulWidget {
  String name;
  String url;
  PolicyPage({required this.name,required this.url});
  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  late WebViewController controller;

  // TODO: Add _interstitialAd
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
              Get.back();
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
    // TODO: implement initState
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: Dispose an InterstitialAd object
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
        } else if (_interstitialAd != null) {
          _interstitialAd?.show();
        } else {
          Get.back();
        }
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.name,style: GoogleFonts.urbanist(textStyle: TextStyle(color: (getStorage.read('isDarkMode') == true) ? Colors.white : Colors.black),),),centerTitle: true,
            leading: IconButton(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else if (_interstitialAd != null) {
                  _interstitialAd?.show();
                } else {
                  Get.back();
                }
              },
              icon:  Icon(
                Icons.arrow_back_ios,
                color: (getStorage.read('isDarkMode') == true) ? Colors.white : Colors.black,
                size: 22,
              ),
            ),
            elevation: 0,
          ),
          body: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.url,
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
          ),
        ),
      ),
    );
  }
}
