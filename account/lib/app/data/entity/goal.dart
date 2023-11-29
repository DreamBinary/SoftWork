/// goalId : 5
/// goalName : "候的特话处感"
/// userId : 8
/// money : 71
/// createDate : "2013-04-27 00:00:00"
/// deadline : "2013-04-29 00:00:00"
/// savedmoney : 0

class Goal {
  num goalId;
  String goalName;
  num userId;
  num money;
  String createDate;
  String deadline;
  num savedMoney;

  Goal(
    this.goalId,
    this.goalName,
    this.userId,
    this.money,
    this.createDate,
    this.deadline,
    this.savedMoney,
  );

  factory Goal.fromJson(dynamic json) => Goal(
        json['goalId'] as num,
        json['goalName'] as String,
        json['userId'] as num,
        json['money'] as num,
        json['createDate'] as String,
        json['deadline'] as String,
        json['saved_money'] as num,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['goalId'] = goalId;
    map['goalName'] = goalName;
    map['userId'] = userId;
    map['money'] = money;
    map['create_date'] = createDate;
    map['deadline'] = deadline;
    map['saved_money'] = savedMoney;
    return map;
  }
}
