import 'dart:convert';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/apimodal/AdsModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdsAPIProvider with ChangeNotifier {
  dynamic _data;
  dynamic get data => _data;

  Future<AdsModal> getAdsApi() async {
    var response = await http.get(Uri.parse(AppUrls.ads),
        headers: {
          "key": AppUrls.key
        });
    _data=jsonDecode(response.body);
    if(response.statusCode==200){
      return AdsModal.fromJson(_data);
    }
    return AdsModal.fromJson(_data);
  }
}