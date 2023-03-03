import 'dart:convert';

AdsModal adsModalFromJson(String str) => AdsModal.fromJson(json.decode(str));
String adsModalToJson(AdsModal data) => json.encode(data.toJson());
class AdsModal {
  AdsModal({
      bool? status, 
      String? message, 
      Advertisements? advertisements,}){
    _status = status;
    _message = message;
    _advertisements = advertisements;
}

  AdsModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _advertisements = json['advertisements'] != null ? Advertisements.fromJson(json['advertisements']) : null;
  }
  bool? _status;
  String? _message;
  Advertisements? _advertisements;
AdsModal copyWith({  bool? status,
  String? message,
  Advertisements? advertisements,
}) => AdsModal(  status: status ?? _status,
  message: message ?? _message,
  advertisements: advertisements ?? _advertisements,
);
  bool? get status => _status;
  String? get message => _message;
  Advertisements? get advertisements => _advertisements;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_advertisements != null) {
      map['advertisements'] = _advertisements?.toJson();
    }
    return map;
  }

}



Advertisements advertisementsFromJson(String str) => Advertisements.fromJson(json.decode(str));
String advertisementsToJson(Advertisements data) => json.encode(data.toJson());
class Advertisements {
  Advertisements({
      String? id, 
      String? native, 
      String? reward, 
      String? banner, 
      String? interstitial, 
      bool? googleAd, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _native = native;
    _reward = reward;
    _banner = banner;
    _interstitial = interstitial;
    _googleAd = googleAd;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Advertisements.fromJson(dynamic json) {
    _id = json['_id'];
    _native = json['native'];
    _reward = json['reward'];
    _banner = json['banner'];
    _interstitial = json['interstitial'];
    _googleAd = json['googleAd'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _native;
  String? _reward;
  String? _banner;
  String? _interstitial;
  bool? _googleAd;
  String? _createdAt;
  String? _updatedAt;
Advertisements copyWith({  String? id,
  String? native,
  String? reward,
  String? banner,
  String? interstitial,
  bool? googleAd,
  String? createdAt,
  String? updatedAt,
}) => Advertisements(  id: id ?? _id,
  native: native ?? _native,
  reward: reward ?? _reward,
  banner: banner ?? _banner,
  interstitial: interstitial ?? _interstitial,
  googleAd: googleAd ?? _googleAd,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get native => _native;
  String? get reward => _reward;
  String? get banner => _banner;
  String? get interstitial => _interstitial;
  bool? get googleAd => _googleAd;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['native'] = _native;
    map['reward'] = _reward;
    map['banner'] = _banner;
    map['interstitial'] = _interstitial;
    map['googleAd'] = _googleAd;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}