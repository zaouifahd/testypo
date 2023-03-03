// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:browser_project/Api_services/Get_App/get_app_controller.dart';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/Api_services/toggle_api/toggle_api_controller.dart';
import 'package:browser_project/apimodal/GetAppModel.dart';
import 'package:browser_project/apimodal/categoryModal.dart';
import 'package:browser_project/home_page.dart';
import 'package:browser_project/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';
import 'package:shimmer/shimmer.dart';
import 'Api_services/Category_Api/category_api_controller.dart';
import 'Api_services/topApp_api/topApp_controller.dart';

ScrollController scrollController = ScrollController();

class AllSitesPage extends StatefulWidget {
  const AllSitesPage({Key? key}) : super(key: key);

  @override
  State<AllSitesPage> createState() => _AllSitesPageState();
}

class _AllSitesPageState extends State<AllSitesPage> {
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
    // TODO: implement dispose
    super.dispose();
    _interstitialAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final getAppProvider = Provider.of<GetAppProvider>(context, listen: false);
    final toggleApp = Provider.of<ToggleAppProvider>(context, listen: false);
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
        backgroundColor: (getStorage.read('isDarkMode') == true)
            ? Color(0xff0E1213)
            : Colors.grey.shade100,
        appBar: AppBar(
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
                Get.offAll(
                  () => HomePage(),
                );
              }
            },
          ),
          title: Text(
            "All Sites",
            style: TextStyle(
              color: (getStorage.read('isDarkMode') == true)
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: FutureBuilder(
            future: categoryProvider.getCategory(),
            builder:
                (BuildContext context, AsyncSnapshot<CategoryModal> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  enabled: true,
                  highlightColor: (getStorage.read('isDarkMode') == true)
                      ? Colors.black45
                      : Colors.grey.shade100,
                  baseColor: (getStorage.read('isDarkMode') == true)
                      ? Colors.black45
                      : Colors.grey.shade100,
                  child: Column(
                    children: [
                      AppBar(),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: kElevationToShadow[2],
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 15,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.3,
                                        mainAxisSpacing: 9.3,
                                        childAspectRatio: 4,
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 15,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return InkWell(
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                splashFactory:
                                                    NoSplash.splashFactory,
                                                child: Container(
                                                  height: 50,
                                                  width: Get.width / 2.3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 11,
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "",
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.add,
                                                          size: 18,
                                                        ),
                                                        splashColor:
                                                            Colors.transparent,
                                                        onPressed: () async {},
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ScrollableListTabView(
                  tabHeight: 50,
                  tabs: List.generate(
                    snapshot.data!.category!.length,
                    (i) {
                      return ScrollableListTab(
                        tab: ListTab(
                          borderRadius: BorderRadius.circular(30),
                          activeBackgroundColor: Colors.lightBlueAccent,
                          icon: Image(
                            width: 18,
                            height: 18,
                            color: (getStorage.read('isDarkMode') == true)
                                ? Colors.white
                                : Colors.black,
                            image: NetworkImage(
                              AppUrls.url +
                                  "/${snapshot.data!.category![i].image}",
                            ),
                          ),
                          label: Text(
                            "${snapshot.data!.category![i].name}",
                            style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          showIconOnList: true,
                        ),
                        body: ListView(
                          padding: EdgeInsets.only(left: 7, right: 7),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            FutureBuilder(
                              future: getAppProvider
                                  .getApp(snapshot.data!.category![i].id!),
                              builder: (BuildContext context,
                                  AsyncSnapshot<GetAppModel> snapshot1) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else if (snapshot1.connectionState ==
                                    ConnectionState.done) {
                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 4,
                                    ),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot1.data!.app!.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return InkWell(
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              child: Container(
                                                height: 50,
                                                width: Get.width / 2.2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color: (getStorage.read(
                                                              'isDarkMode') ==
                                                          true)
                                                      ? Color(0xff181C1F)
                                                      : Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          AppUrls
                                                              .url +
                                                              "/${snapshot1.data!.app![i].icon}"),
                                                      radius: 11,
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      snapshot1
                                                          .data!.app![i].name
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.urbanist(
                                                        textStyle: TextStyle(
                                                          color: (getStorage.read(
                                                                      'isDarkMode') ==
                                                                  true)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    (snapshot1.data!.app![i]
                                                                .isTop ==
                                                            false)
                                                        ? IconButton(
                                                            icon: Icon(
                                                              Icons.add,
                                                              size: 18,
                                                            ),
                                                            splashColor: Colors
                                                                .transparent,
                                                            onPressed:
                                                                () async {
                                                              toggleApp
                                                                  .toggleAppApi(
                                                                      snapshot1
                                                                          .data!
                                                                          .app![
                                                                              i]
                                                                          .id
                                                                          .toString());
                                                              print(toggleApp
                                                                  .data);
                                                              final topApp =
                                                                  Provider.of<
                                                                          TopAppProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              topApp.topApp();
                                                              print(
                                                                  _interstitialAd);
                                                              if (_interstitialAd !=
                                                                  null) {
                                                                topApp.topApp();
                                                                _interstitialAd
                                                                    ?.show();
                                                              } else {
                                                                await topApp
                                                                    .topApp();
                                                                Navigator.of(
                                                                        context)
                                                                    .pushNamedAndRemoveUntil(
                                                                        "/home_page",
                                                                        (route) =>
                                                                            false);
                                                              }
                                                            },
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                                return Shimmer.fromColors(
                                  enabled: true,
                                  highlightColor:
                                      (getStorage.read('isDarkMode') == true)
                                          ? Colors.black45
                                          : Colors.grey.shade100,
                                  baseColor:
                                      (getStorage.read('isDarkMode') == true)
                                          ? Colors.black45
                                          : Colors.grey.shade300,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        splashFactory: NoSplash.splashFactory,
                                        child: Container(
                                          height: 40,
                                          width: Get.width / 2.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              CircleAvatar(
                                                radius: 11,
                                                backgroundColor: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 18,
                                                ),
                                                splashColor: Colors.transparent,
                                                onPressed: () async {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        splashFactory: NoSplash.splashFactory,
                                        child: Container(
                                          height: 40,
                                          width: Get.width / 2.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              CircleAvatar(
                                                radius: 11,
                                                backgroundColor: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 18,
                                                ),
                                                splashColor: Colors.transparent,
                                                onPressed: () async {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
