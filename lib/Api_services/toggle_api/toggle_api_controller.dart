import 'dart:convert';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/apimodal/ToggleModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToggleAppProvider with ChangeNotifier {
  dynamic _data;

  dynamic get data => _data;

  Future<ToggleModal> toggleAppApi(String id) async {

    final queryParameters = {
      "key": AppUrls.key
    };

    final uri = Uri.https(
        AppUrls.url1,"/app/$id", queryParameters);
    http.Response res = await http.put(uri);
     _data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return ToggleModal.fromJson(_data);
    }
     return ToggleModal.fromJson(_data);
  }
}
