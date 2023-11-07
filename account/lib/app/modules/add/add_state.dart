import 'package:flutter/material.dart';

import '../../utils/date_util.dart';

class AddState {
  var moneyCtrl = TextEditingController();
  var dateCtrl = TextEditingController(text: DateUtil.getNowFormattedDate());
  var nameCtrl = TextEditingController();
  var merchantCtrl = TextEditingController();
  var remarkCtrl = TextEditingController();
  int typeId = 0;
  String? imgUrl;

  List<String> wordList = [];

  AddState() {
    ///Initialize variables
  }
}
