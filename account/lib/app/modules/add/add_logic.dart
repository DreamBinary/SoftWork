import 'package:account/app/data/entity/consume.dart';
import 'package:account/app/data/net/api_book.dart';
import 'package:account/app/data/net/api_consume.dart';
import 'package:get/get.dart';

import '../../utils/date_util.dart';
import 'add_state.dart';

class AddLogic extends GetxController {
  final AddState state = AddState();

  void init(ConsumeData cData) {
    state.moneyCtrl.text = cData.amount.abs().toString();
    state.dateCtrl.text = cData.consumeDate;
    state.nameCtrl.text = cData.consumptionName;
    state.merchantCtrl.text = cData.store;
    state.remarkCtrl.text = cData.description;
    state.typeId = cData.typeId;
    state.imgUrl = cData.imgUrl;
  }

  void initWords(List<String> strL) {
    state.wordList = strL;
  }

  Future<bool> upAdd() async {
    var cData = ConsumeData(
      consumptionName: state.nameCtrl.text,
      description: state.remarkCtrl.text,
      amount: -double.parse(state.moneyCtrl.text),
      typeId: state.typeId,
      store: state.merchantCtrl.text,
      consumeTime: state.dateCtrl.text,
      consumeDate: state.dateCtrl.text,
      credential: state.imgUrl ?? "",
    );
    num? id = await ApiConsume.addConsume(cData);
    if (id == null) {
      return false;
    }
    var res = await ApiBook.addBookRecord(124, id);
    if (res) {
      clear();
    }
    return res;
  }

  void clear() {
    state.moneyCtrl.clear();
    state.dateCtrl.text = DateUtil.getNowFormattedDate();
    state.nameCtrl.clear();
    state.merchantCtrl.clear();
    state.remarkCtrl.clear();
    state.typeId = 0;
    state.imgUrl = null;
  }
}
