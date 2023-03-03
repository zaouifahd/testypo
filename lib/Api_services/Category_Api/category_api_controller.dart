import 'dart:convert';
import 'package:browser_project/Api_services/app_urls.dart';
import 'package:browser_project/apimodal/categoryModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  dynamic _data;

  dynamic get data => _data;

  Future<CategoryModal> getCategory() async {

    final queryParameters = {
      "key": AppUrls.key
    };
    final uri = Uri.http(
        AppUrls.url1,"/category/all", queryParameters);
    http.Response res = await http.get(uri);
    _data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return CategoryModal.fromJson(_data);
    }
    return CategoryModal.fromJson(_data);
  }
}
