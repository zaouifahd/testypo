// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, import_of_legacy_library_into_null_safe, must_be_immutable
import 'dart:async';
import 'package:browser_project/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebPage extends StatefulWidget {
  String name;
  String url;

  AppWebPage({required this.name, required this.url});

  @override
  _AppWebPageState createState() => _AppWebPageState();
}

class _AppWebPageState extends State<AppWebPage> {
  late WebViewController controller;
  InterstitialAd? _interstitialAd;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId:interstitialAd,
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

  String data = "";

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        data = "data";
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments;
    print(res);
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
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.name,
            style: TextStyle(
              color: (getStorage.read('isDarkMode') == true)
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          leading: IconButton(
            icon:  Icon(
              Icons.arrow_back,
              color: (getStorage.read('isDarkMode') == true)
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              } else if (_interstitialAd != null) {
                _interstitialAd?.show();
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: Stack(
          children: [
            Builder(builder: (BuildContext context) {
              return WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
              );
            }),
            (data.isEmpty)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message.message),
            ),
          );
        });
  }
}
