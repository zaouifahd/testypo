import 'dart:convert';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/apimodal/gameModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GameApiProvider with ChangeNotifier {
  dynamic _data;
  dynamic get data => _data;

  Future<GameModal> getGameApi() async {
    var response = await http.get(Uri.parse(AppUrls.gameApiUrl),
        headers: {
      "key": AppUrls.key
    });
    _data=jsonDecode(response.body);
    if(response.statusCode==200){
      return GameModal.fromJson(_data);
    }
    return GameModal.fromJson(_data);
  }
}
