import 'dart:convert';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/Api_services/setting_api/setting_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingApiProvider with ChangeNotifier {
  dynamic _data;

  dynamic get data => _data;

  Future<SettingModal> settingApi() async {
    final uri = Uri.https(AppUrls.url1, "/setting/create");
    http.Response res = await http.post(uri,
        headers: {"key": AppUrls.key}, body: {"isAppActive": "true"});

    _data = jsonDecode(res.body);
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      return SettingModal.fromJson(_data);
    }
    return SettingModal.fromJson(_data);
  }
}
