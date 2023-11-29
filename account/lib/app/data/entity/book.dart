/// ledgerId : 42
/// userId : 8
/// ledgerName : "问今包选她持"
/// coverMsg : ""
/// createTime : "1996-11-08 02:12:48"
/// updateTime : "2006-11-06 18:23:00"

class Book {
  Book(this._ledgerId, this._userId, this._ledgerName, this._coverMsg,
      this._createTime, this._updateTime);

  factory Book.fromJson(dynamic json) => Book(
        json['ledgerId'] as num,
        json['userId'] as num,
        json['ledgerName'] as String,
        json['coverMsg'] as String,
        json['createTime'] as String,
        json['updateTime'] as String,
      );

  // toJson
  Map<String, dynamic> toJson() => {
        'ledgerId': _ledgerId,
        'userId': _userId,
        'ledgerName': _ledgerName,
        'coverMsg': _coverMsg,
        'createTime': _createTime,
        'updateTime': _updateTime,
      };

  num _ledgerId;
  num _userId;
  String _ledgerName;
  String _coverMsg;
  String _createTime;
  String _updateTime;

  num get ledgerId => _ledgerId;

  num get userId => _userId;

  String get ledgerName => _ledgerName;

  String get coverMsg => _coverMsg;

  String get createTime => _createTime;

  String get updateTime => _updateTime;
}
