import 'dart:convert';


ToggleModal toggleModalFromJson(String str) => ToggleModal.fromJson(json.decode(str));
String toggleModalToJson(ToggleModal data) => json.encode(data.toJson());
class ToggleModal {
  ToggleModal({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ToggleModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
ToggleModal copyWith({  bool? status,
  String? message,
  Data? data,
}) => ToggleModal(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
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

  Data.fromJson(dynamic json) {
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
Data copyWith({  String? id,
  String? name,
  String? icon,
  String? url,
  Category? category,
  bool? isTop,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
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

/// _id : "631f02270aa2fce65ced7319"
/// name : "Shopping"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
Category copyWith({  String? id,
  String? name,
}) => Category(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }

}