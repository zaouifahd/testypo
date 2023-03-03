import 'dart:convert';


GetAppModel getAppModelFromJson(String str) => GetAppModel.fromJson(json.decode(str));
String getAppModelToJson(GetAppModel data) => json.encode(data.toJson());
class GetAppModel {
  GetAppModel({
      bool? status, 
      String? message, 
      List<App>? app,}){
    _status = status;
    _message = message;
    _app = app;
}

  GetAppModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['app'] != null) {
      _app = [];
      json['app'].forEach((v) {
        _app?.add(App.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<App>? _app;
GetAppModel copyWith({  bool? status,
  String? message,
  List<App>? app,
}) => GetAppModel(  status: status ?? _status,
  message: message ?? _message,
  app: app ?? _app,
);
  bool? get status => _status;
  String? get message => _message;
  List<App>? get app => _app;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_app != null) {
      map['app'] = _app?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



App appFromJson(String str) => App.fromJson(json.decode(str));
String appToJson(App data) => json.encode(data.toJson());
class App {
  App({
      String? id, 
      String? name, 
      String? icon, 
      String? url, 
      Category? category, 
      bool? isTop, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _icon = icon;
    _url = url;
    _category = category;
    _isTop = isTop;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  App.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _icon = json['icon'];
    _url = json['URL'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _isTop = json['isTop'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _name;
  String? _icon;
  String? _url;
  Category? _category;
  bool? _isTop;
  String? _createdAt;
  String? _updatedAt;
App copyWith({  String? id,
  String? name,
  String? icon,
  String? url,
  Category? category,
  bool? isTop,
  String? createdAt,
  String? updatedAt,
}) => App(  id: id ?? _id,
  name: name ?? _name,
  icon: icon ?? _icon,
  url: url ?? _url,
  category: category ?? _category,
  isTop: isTop ?? _isTop,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  String? get url => _url;
  Category? get category => _category;
  bool? get isTop => _isTop;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['URL'] = _url;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['isTop'] = _isTop;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}

/// _id : "63255cf4627a282d68f3ed5b"
/// image : "storage/1663393025560news.png"
/// name : "News"
/// isTop : true
/// createdAt : "2022-09-17T05:36:52.009Z"
/// updatedAt : "2022-09-17T06:37:29.143Z"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      String? id, 
      String? image, 
      String? name, 
      bool? isTop, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _image = image;
    _name = name;
    _isTop = isTop;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
    _name = json['name'];
    _isTop = json['isTop'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _image;
  String? _name;
  bool? _isTop;
  String? _createdAt;
  String? _updatedAt;
Category copyWith({  String? id,
  String? image,
  String? name,
  bool? isTop,
  String? createdAt,
  String? updatedAt,
}) => Category(  id: id ?? _id,
  image: image ?? _image,
  name: name ?? _name,
  isTop: isTop ?? _isTop,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get image => _image;
  String? get name => _name;
  bool? get isTop => _isTop;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    map['name'] = _name;
    map['isTop'] = _isTop;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}