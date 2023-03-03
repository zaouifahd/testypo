
class GameModal {
  GameModal({
      bool? status, 
      String? message, 
      List<Game>? game,}){
    _status = status;
    _message = message;
    _game = game;
}

  GameModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['game'] != null) {
      _game = [];
      json['game'].forEach((v) {
        _game?.add(Game.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Game>? _game;
GameModal copyWith({  bool? status,
  String? message,
  List<Game>? game,
}) => GameModal(  status: status ?? _status,
  message: message ?? _message,
  game: game ?? _game,
);
  bool? get status => _status;
  String? get message => _message;
  List<Game>? get game => _game;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_game != null) {
      map['game'] = _game?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Game {
  Game({
      String? id, 
      String? icon, 
      bool? isTop, 
      String? createdAt, 
      String? updatedAt, 
      num? rating, 
      String? url, 
      String? name,}){
    _id = id;
    _icon = icon;
    _isTop = isTop;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _rating = rating;
    _url = url;
    _name = name;
}

  Game.fromJson(dynamic json) {
    _id = json['_id'];
    _icon = json['icon'];
    _isTop = json['isTop'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _rating = json['rating'];
    _url = json['URL'];
    _name = json['name'];
  }
  String? _id;
  String? _icon;
  bool? _isTop;
  String? _createdAt;
  String? _updatedAt;
  num? _rating;
  String? _url;
  String? _name;
Game copyWith({  String? id,
  String? icon,
  bool? isTop,
  String? createdAt,
  String? updatedAt,
  num? rating,
  String? url,
  String? name,
}) => Game(  id: id ?? _id,
  icon: icon ?? _icon,
  isTop: isTop ?? _isTop,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  rating: rating ?? _rating,
  url: url ?? _url,
  name: name ?? _name,
);
  String? get id => _id;
  String? get icon => _icon;
  bool? get isTop => _isTop;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get rating => _rating;
  String? get url => _url;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['icon'] = _icon;
    map['isTop'] = _isTop;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['rating'] = _rating;
    map['URL'] = _url;
    map['name'] = _name;
    return map;
  }

}