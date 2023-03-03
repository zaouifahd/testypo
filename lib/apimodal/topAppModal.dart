import 'dart:convert';


TopAppModal topAppModalFromJson(String str) => TopAppModal.fromJson(json.decode(str));
String topAppModalToJson(TopAppModal data) => json.encode(data.toJson());
class TopAppModal {
  TopAppModal({
      bool? status, 
      String? message, 
      List<App>? app,}){
    _status = status;
    _message = message;
    _app = app;
}

  TopAppModal.fromJson(dynamic json) {
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
TopAppModal copyWith({  bool? status,
  String? message,
  List<App>? app,
}) => TopAppModal(  status: status ?? _status,
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
      String? category, 
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
    _category = json['category'];
    _isTop = json['isTop'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _name;
  String? _icon;
  String? _url;
  String? _category;
  bool? _isTop;
  String? _createdAt;
  String? _updatedAt;
App copyWith({  String? id,
  String? name,
  String? icon,
  String? url,
  String? category,
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
  String? get category => _category;
  bool? get isTop => _isTop;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['URL'] = _url;
    map['category'] = _category;
    map['isTop'] = _isTop;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}