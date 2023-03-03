/// status : true
/// message : "Success!!"
/// setting : {"privacyPolicyLink":"PRIVACY POLICY LINK","privacyPolicyText":"PRIVACY POLICY TEXT","isAppActive":true,"_id":"634e2d42a0f7dd0a70aa4cb4"}

class SettingModal {
  SettingModal({
      bool? status, 
      String? message, 
      Setting? setting,}){
    _status = status;
    _message = message;
    _setting = setting;
}

  SettingModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
  }
  bool? _status;
  String? _message;
  Setting? _setting;
SettingModal copyWith({  bool? status,
  String? message,
  Setting? setting,
}) => SettingModal(  status: status ?? _status,
  message: message ?? _message,
  setting: setting ?? _setting,
);
  bool? get status => _status;
  String? get message => _message;
  Setting? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    return map;
  }

}

/// privacyPolicyLink : "PRIVACY POLICY LINK"
/// privacyPolicyText : "PRIVACY POLICY TEXT"
/// isAppActive : true
/// _id : "634e2d42a0f7dd0a70aa4cb4"

class Setting {
  Setting({
      String? privacyPolicyLink, 
      String? privacyPolicyText, 
      bool? isAppActive, 
      String? id,}){
    _privacyPolicyLink = privacyPolicyLink;
    _privacyPolicyText = privacyPolicyText;
    _isAppActive = isAppActive;
    _id = id;
}

  Setting.fromJson(dynamic json) {
    _privacyPolicyLink = json['privacyPolicyLink'];
    _privacyPolicyText = json['privacyPolicyText'];
    _isAppActive = json['isAppActive'];
    _id = json['_id'];
  }
  String? _privacyPolicyLink;
  String? _privacyPolicyText;
  bool? _isAppActive;
  String? _id;
Setting copyWith({  String? privacyPolicyLink,
  String? privacyPolicyText,
  bool? isAppActive,
  String? id,
}) => Setting(  privacyPolicyLink: privacyPolicyLink ?? _privacyPolicyLink,
  privacyPolicyText: privacyPolicyText ?? _privacyPolicyText,
  isAppActive: isAppActive ?? _isAppActive,
  id: id ?? _id,
);
  String? get privacyPolicyLink => _privacyPolicyLink;
  String? get privacyPolicyText => _privacyPolicyText;
  bool? get isAppActive => _isAppActive;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['privacyPolicyLink'] = _privacyPolicyLink;
    map['privacyPolicyText'] = _privacyPolicyText;
    map['isAppActive'] = _isAppActive;
    map['_id'] = _id;
    return map;
  }

}