import 'dart:convert';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/apimodal/topAppModal.dart';
import 'package:browser_project/list/api_data_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopAppProvider with ChangeNotifier {
  dynamic _data;
  dynamic get data => _data;

  Future<TopAppModal> topApp() async {
    final queryParameters = {"type": "Top"};
    final uri = Uri.http(AppUrls.url1, "/app", queryParameters);
    http.Response res = await http.get(
      uri,
      headers: {"key": AppUrls.key},
    );
    _data = jsonDecode(res.body);
    abc.addAll(_data["app"]);
    abc.forEach((element) {
      topAddData.insert(topAddData.length -2 ,element);
    });
    final jsonList = topAddData
        .map((item) =>
            jsonEncode(item))
        .toList();
    final uniqueJsonList =
        jsonList.toSet().toList();

    topAddData = uniqueJsonList
        .map((item) =>
            jsonDecode(item))
        .toList();











    if (res.statusCode == 200) {
      return TopAppModal.fromJson(_data);
    }
    return TopAppModal.fromJson(_data);
  }
}
