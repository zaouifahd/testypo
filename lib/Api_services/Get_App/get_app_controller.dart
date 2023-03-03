import 'dart:convert';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/apimodal/GetAppModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAppProvider with ChangeNotifier {
  dynamic _data;

  dynamic get data => _data;

  Future<GetAppModel> getApp(String categoryId) async {
    final queryParameters = {
      "categoryId": categoryId
    };
    final uri =
        Uri.http(AppUrls.url1, "/app/categoryWiseApp", queryParameters);
    http.Response res = await http.get(uri,headers: {"key":AppUrls.key});
    _data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return GetAppModel.fromJson(_data);
    }
    return GetAppModel.fromJson(_data);
  }
}
