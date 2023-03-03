// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:browser_project/Api_services/Ads_Api/ads_api_controller.dart';
import 'package:browser_project/Api_services/Category_Api/category_api_controller.dart';
import 'package:browser_project/Api_services/toggle_api/toggle_api_controller.dart';
import 'package:browser_project/Api_services/topApp_api/topApp_controller.dart';
import 'package:browser_project/allsites_page.dart';
import 'package:browser_project/game_page.dart';
import 'package:browser_project/home_page.dart';
import 'package:browser_project/list/api_data_list.dart';
import 'package:browser_project/playstore_web.dart';
import 'package:browser_project/services/theme_services.dart';
import 'package:browser_project/setting_page.dart';
import 'package:browser_project/splash_screen.dart';
import 'package:browser_project/theme/theme.dart';
import 'package:browser_project/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Api_services/Game_Api/game_api_controller.dart';
import 'Api_services/Get_App/get_app_controller.dart';

String data = "";
var imageUrl;
final getStorage = GetStorage();
String bannerAd = '';
String nativeAd = '';
String rewardAd = '';
String interstitialAd = '';
String privacyPolicyLink = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
  bool isDarkMode = getStorage.read(GetStorageKey.IS_DARK_MODE) ?? false;
  getStorage.write(GetStorageKey.IS_DARK_MODE, isDarkMode);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  savedata1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getString('key')!;
    customData = json.decode(data);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context)  {
    savedata1();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => GameApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => GetAppProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => TopAppProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ToggleAppProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AdsAPIProvider(),
        ),
      ],
      child: GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashScreen(),
          ),
          GetPage(
            name: '/home_page',
            page: () => const HomePage(),
          ),
          GetPage(
            name: '/allsites_page',
            page: () => const AllSitesPage(),
          ),
          GetPage(
            name: '/url',
            page: () => const UrlWebPage(),
          ),
          GetPage(
            name: '/playstore_web',
            page: () => PlayStoreWeb(
              name: '',
              url: '',
            ),
          ),
          GetPage(
            name: '/game_page',
            page: () => const GamePage(),
          ),
          GetPage(
            name: '/setting_page',
            page: () => const SettingPage(),
          ),
        ],
      ),
    );
  }
}
