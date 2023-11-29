/// multiLedgerId : 6
/// multiLedgerName : "123123区"
/// description : "团个量度场且铁边与亲当候表。毛员传格那族委式化两非至公律识新。火题维级节意西指体目天装至直达。持多实选住连所般资机院计带。海认维亲外联起处行区并林将许。义化影我意系通门一角代种派县从。"
/// password : "123456"
/// modifyTime : "2023-11-29 11:15:24"

class MultiBook {
  MultiBook(this._multiLedgerId, this._multiLedgerName, this._description,
      this._password, this._modifyTime);

  factory MultiBook.fromJson(dynamic json) => MultiBook(
        json['multiLedgerId'] as num,
        json['multiLedgerName'] as String,
        json['description'] as String,
        json['password'] as String,
        json['modifyTime'] as String,
      );
  num _multiLedgerId;
  String _multiLedgerName;
  String _description;
  String _password;
  String _modifyTime;

  num get multiLedgerId => _multiLedgerId;

  String get multiLedgerName => _multiLedgerName;

  String get description => _description;

  String get password => _password;

  String get modifyTime => _modifyTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['multiLedgerId'] = _multiLedgerId;
    map['multiLedgerName'] = _multiLedgerName;
    map['description'] = _description;
    map['password'] = _password;
    map['modifyTime'] = _modifyTime;
    return map;
  }
}
