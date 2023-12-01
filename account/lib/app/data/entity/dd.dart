/// consumptionId : 1008
/// consumptionName : "同学聚餐"
/// description : "聚餐AA制"
/// amount : -70
/// typeId : 12
/// store : "学生街"
/// consumeTime : "2023-04-15 16:30:20"
/// credential : "default"

class Dd {
  Dd(
      this._consumptionId,
      this._consumptionName,
      this._description,
      this._amount,
      this._typeId,
      this._store,
      this._consumeTime,
      this._credential);

  factory Dd.fromJson(dynamic json) {
    var str = json['consumeTime'].toString().split(" ");
    var cTime = str.length > 1 ? str[1] : "00:00:00";
    var cDate = str[0];
    return Dd(
      json['consumptionId'],
      json['consumptionName'],
      json['description'],
      json['amount'],
      json['typeId'],
      json['store'],
      json['consumeTime'],
      json['credential'],
    );
  }

  num _consumptionId;
  String _consumptionName;
  String _description;
  num _amount;
  num _typeId;
  String _store;
  String _consumeTime;
  String _credential;

  num get consumptionId => _consumptionId;

  String get consumptionName => _consumptionName;

  String get description => _description;

  num get amount => _amount;

  num get typeId => _typeId;

  String get store => _store;

  String get consumeTime => _consumeTime;

  String get credential => _credential;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['consumptionId'] = _consumptionId;
    map['consumptionName'] = _consumptionName;
    map['description'] = _description;
    map['amount'] = _amount;
    map['typeId'] = _typeId;
    map['store'] = _store;
    map['consumeTime'] = _consumeTime;
    map['credential'] = _credential;
    return map;
  }
}
