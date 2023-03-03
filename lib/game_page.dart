// ignore_for_file: unnecessary_null_comparison
import 'package:browser_project/Api_services/Game_Api/game_api_controller.dart';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/apimodal/gameModal.dart';
import 'package:browser_project/main.dart';
import 'package:browser_project/playstore_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameApiProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (_interstitialAd != null) {
          _interstitialAd?.show();
        } else {
          Get.back();
        }
        return false;
      },
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "GamePage",
              style: TextStyle(
                color: (getStorage.read('isDarkMode') == true)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: (getStorage.read('isDarkMode') == true)
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () async {
                if (_interstitialAd != null) {
                  _interstitialAd?.show();
                } else {
                  Get.back();
                }
              },
            ),
          ),
          body: FutureBuilder(
            future: gameProvider.getGameApi(),
            builder: (context, AsyncSnapshot<GameModal> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.game!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        AppUrls.url+"/${snapshot.data!.game![i].icon}"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data!.game![i].name}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    "${snapshot.data!.game![i].rating} ⭐",
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.play_arrow,
                                color: (getStorage.read('isDarkMode') == true)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.to(
                            PlayStoreWeb(
                              name: snapshot.data!.game![i].name.toString(),
                              url: snapshot.data!.game![i].url.toString(),
                            ),
                          );
                        });
                  },
                );
              }
              return Shimmer.fromColors(
                highlightColor: (getStorage.read('isDarkMode') == true)
                    ? Colors.black45
                    : Colors.grey.shade100,
                baseColor: (getStorage.read('isDarkMode') == true)
                    ? Colors.black45
                    : Colors.grey.shade100,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, i) {
                    return InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
