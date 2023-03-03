// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/app_web_page.dart';
import 'package:browser_project/indicator.dart';
import 'package:browser_project/list/api_data_list.dart';
import 'package:browser_project/main.dart';
import 'package:browser_project/setting_page.dart';
import 'package:favicon/favicon.dart' as favicon;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Api_services/topApp_api/topApp_controller.dart';
import 'game_page.dart';
import 'list/data_of_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';

savedata() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  data = prefs.getString('key')!;
  customData = json.decode(data);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  dynamic top = 0;
  String data = "";
  bool indicator = false;
  late BannerAd _bannerAd;

  void loadBannerAds() async {
    _bannerAd = BannerAd(
      adUnitId: bannerAd,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    loadBannerAds();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        data = "data";
      });
    });
  }

  @override
  void dispose() {
    if (_bannerAd == null) {
      return null;
    } else {
      _bannerAd.dispose();
    }

    super.dispose();
  }

  bool isVisible = false;

  savedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("key") == null) {
    } else {
      data = prefs.getString('key')!;
      customData = json.decode(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topApp = Provider.of<TopAppProvider>(context, listen: false);
    topApp.topApp();
    customData.forEach((element) {
      topAddData.insert(topAddData.length - 2, element);
    });
    final jsonList = topAddData.map((item) => jsonEncode(item)).toList();
    final uniqueJsonList = jsonList.toSet().toList();

    topAddData = uniqueJsonList.map((item) => jsonDecode(item)).toList();


    savedata();
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              forceElevated: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: (getStorage.read('isDarkMode') == true)
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    Get.to(
                      SettingPage(),
                    );
                  },
                ),
              ],

              /// The part you use this package
              flexibleSpace: CustomizableSpaceBar(
                builder: (context, scrollingRate) {
                  return Stack(
                    children: [
                      Container(
                        height: Get.height / 2.45,
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: (scrollingRate < 1)
                              ? LinearGradient(
                                  colors:
                                      (getStorage.read('isDarkMode') == true)
                                          ? [
                                              Color(0xFF192226),
                                              // Color(0xFF1E2B30),
                                              Color(0xFF26373f),
                                            ]
                                          : [
                                              Color(0xFF7CD4ED),
                                              Color(0xFF49ABF4),
                                              Color(0xFF0072FF),
                                            ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight)
                              : LinearGradient(
                                  colors: (getStorage.read('isDarkMode') ==
                                          true)
                                      ? [Color(0xff181C1F), Color(0xff181C1F)]
                                      : [Colors.white, Colors.white],
                                ),
                        ),
                        child: Text(
                          "App Browser",
                          style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: scrollingRate < 1 ? 15 : scrollingRate,
                          right: scrollingRate < 1 ? 15 : scrollingRate,
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            height: Get.height / 13,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: (getStorage.read('isDarkMode') == true)
                                  ? Color(0xff181C1F)
                                  : Colors.white,
                              boxShadow: kElevationToShadow[2],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller: controller,
                              onFieldSubmitted: (val) {
                                search = val;
                                (controller.text.isEmpty)
                                    ? Fluttertoast.showToast(
                                        msg: "Please Search first",
                                        textColor:
                                            (getStorage.read('isDarkMode') ==
                                                    true)
                                                ? Colors.black
                                                : Colors.white,
                                        backgroundColor:
                                            (getStorage.read('isDarkMode') ==
                                                    true)
                                                ? Colors.white
                                                : Colors.black,
                                      )
                                    : (val.isURL)
                                        ? Get.to(
                                  AppWebPage(
                                    name: "",
                                    url: val,
                                  ),
                                )
                                        : Get.toNamed(
                                            'url',
                                            arguments:
                                            AppUrls.googleLink+"$search",
                                          );
                                controller.clear();
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 2,
                                  minHeight: 2,
                                ),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 2,
                                  minHeight: 2,
                                ),
                                icon: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Color(0xFF009CFF),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: "Search or Address",
                                hintStyle: GoogleFonts.urbanist(
                                  textStyle: TextStyle(
                                    color:
                                        (getStorage.read('isDarkMode') == true)
                                            ? Colors.white
                                            : Colors.black45,
                                    fontSize: 17,
                                  ),
                                ),
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              /// End of the part
              expandedHeight: Get.height / 2.45,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: Get.height / 1.2,
                    padding: EdgeInsets.only(top: 30, left: 5),
                    child: SizedBox(
                      height: Get.height,
                      child: GridView.builder(
                        padding: EdgeInsets.only(left: 5),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 3.0,
                          mainAxisSpacing: 14,
                        ),
                        itemCount: topAddData.length,
                        itemBuilder: (context, i) {
                          final jsonList = customData
                              .map((item) => jsonEncode(item))
                              .toList();
                          final uniqueJsonList = jsonList.toSet().toList();

                          customData = uniqueJsonList
                              .map((item) => jsonDecode(item))
                              .toList();
                          return InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: buildCircleAvatar(
                                      (topAddData[i]["name"] == "GameZone" ||
                                              topAddData[i]["name"] == "More" ||
                                              topAddData[i]["name"] == "Add")
                                          ? topAddData[i]["icon"]
                                          : (topAddData[i]["id"] == "ADD")
                                              ? topAddData[i]["icon"]
                                              : AppUrls.url+"/${topAddData[i]["icon"]}",
                                      (topAddData[i]["name"] == "GameZone" ||
                                              topAddData[i]["name"] == "More" ||
                                              topAddData[i]["name"] == "Add")
                                          ? 1
                                          : 2),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 70,
                                  child: Text(
                                    topAddData[i]["name"].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.urbanist(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: (getStorage.read('isDarkMode') ==
                                                true)
                                            ? Colors.white
                                            : Colors.black45,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              if (topAddData[i]["name"] == "GameZone") {
                                // Get.toNamed("game_page");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return GamePage();
                                    },
                                  ),
                                );
                              } else if (topAddData[i]["name"] == "More") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Indicator();
                                    },
                                  ),
                                );
                              } else if (topAddData[i]["name"] == "Add") {
                                setState(() {
                                  indicator = false;
                                });
                                Get.dialog(
                                  AlertDialog(
                                    backgroundColor:
                                        (getStorage.read('isDarkMode') == true)
                                            ? Color(0xff0E1213)
                                            : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        child: Form(
                                          key: myKey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                autofocus: true,
                                                autocorrect: false,
                                                focusNode: FocusNode(),
                                                controller: nameController,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 15,
                                                          horizontal: 10),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  label: Text("Name"),
                                                ),
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return "Please Enter Name";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              TextFormField(
                                                  controller: urlController,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15,
                                                            horizontal: 10,),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    label: Text("Address"),
                                                  ),
                                                  validator: (val) {
                                                    String pattern =
                                                        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
                                                    RegExp regExp =
                                                        new RegExp(pattern);
                                                    if (val!.length == 0) {
                                                      return 'Please Enter Url';
                                                    } else if (!regExp
                                                        .hasMatch(val)) {
                                                      return 'Please Enter valid Url';
                                                    }
                                                    return null;
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: (getStorage
                                                        .read('isDarkMode') ==
                                                    true)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          nameController.clear();
                                          imageController.clear();
                                          urlController.clear();
                                          Get.back();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Add",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        onPressed: () async {
                                          print(imageUrl);
                                          indicator = true;
                                          if (myKey.currentState!.validate()) {
                                            Get.to(
                                              Cir(),
                                            );
                                            var iconUrl = await favicon
                                                    .FaviconFinder
                                                .getBest(urlController.text);
                                            imageUrl = iconUrl!.url;
                                            if(imageUrl == null){
                                              print("ImageUrl is null");
                                            }
                                            else{
                                              customData
                                                  .insert(customData.length, {
                                                "icon": imageUrl,
                                                "name": nameController.text,
                                                "category": '',
                                                "createdAt": '',
                                                "id": 'ADD',
                                                'isTop': '',
                                                'updatedAt': '',
                                                'URL': urlController.text
                                              });
                                              print(imageUrl);

                                              final jsonList = customData
                                                  .map((item) => jsonEncode(item))
                                                  .toList();
                                              final uniqueJsonList =
                                              jsonList.toSet().toList();

                                              customData = uniqueJsonList
                                                  .map((item) => jsonDecode(item))
                                                  .toList();

                                              SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                              prefs.setString(
                                                "key",
                                                json.encode(customData),
                                              );
                                            }
                                          }
                                          nameController.clear();
                                          imageController.clear();
                                          urlController.clear();
                                        },
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                    title: Text("Add to Favorites"),
                                    alignment: Alignment.center,
                                  ),
                                );
                              } else {
                                Get.to(
                                  AppWebPage(
                                    name: topAddData[i]["name"].toString(),
                                    url: topAddData[i]["URL"].toString(),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          child: AdWidget(ad: _bannerAd),
        ),
      ),
    );
  }

  CircleAvatar buildCircleAvatar(String image, int type) {
    return (type == 1)
        ? CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(image),
            radius: 25,
          )
        : CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(image),
            radius: 25,
          );
  }
}

class Cir extends StatefulWidget {
  const Cir({Key? key}) : super(key: key);

  @override
  State<Cir> createState() => _CirState();
}

class _CirState extends State<Cir> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/demo123.png"),
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: new Container(
                decoration:  BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          Center(
            child: SpinKitSpinningLines(
              size: 150,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
