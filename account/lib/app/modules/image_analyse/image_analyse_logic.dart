import 'dart:math';

import 'package:account/app/data/entity/consume.dart';
import 'package:account/app/data/entity/data.dart';
import 'package:account/app/data/net/api_consume.dart';
import 'package:get/get.dart';

import 'image_analyse_state.dart';

class ImageAnalyseLogic extends GetxController {
  final ImageAnalyseState state = ImageAnalyseState();

  Future<Data> getThirtyOutList(String date) async {
    List<double> thirtyOutList = [];
    // random from 30 to 160
    var random = Random();
    for (var i = 0; i < 30; ++i) {
      thirtyOutList.add(random.nextDouble() * 130 + 30);
    }
    return Data(thirtyOutList);

    // if (state.thirtyOutList == null || state.date != date) {
    //   state.date = date;
    //   // ApiConsume.getRangeRecordMap(start: "", end: )
    //   var start = DateTime.parse("$date 00:00:00");
    //   var end = start.subtract(const Duration(days: 30));
    //
    //   var record = await ApiConsume.getRangeRecordMap(
    //     start: DateUtil.getFormattedDateTime(start),
    //     end: DateUtil.getFormattedDateTime(end),
    //   );
    //
    //   List<double> thirtyOutList = [];
    //   for (var element in record) {
    //     var sum = 0.0;
    //     element.forEach((key, value) {
    //       for (var e in value) {
    //         sum += e.amount;
    //       }
    //     });
    //     thirtyOutList.add(sum);
    //   }
    //   state.thirtyOutList = thirtyOutList;
    // }
    // return Data(state.thirtyOutList!);
  }

  // Future<void> getPercentage(String date) async {
  //   if (state.percentage == null || state.date != date) {
  //     state.date = date;
  //     var start = DateTime.parse("$date 00:00:00");
  //     var end = start.subtract(const Duration(days: 30));
  //
  //     var record = await ApiConsume.getRangeRecordMap(
  //       start: DateUtil.getFormattedDateTime(start),
  //       end: DateUtil.getFormattedDateTime(end),
  //     );
  //
  //     List<Map<String, double>> percentage = List.generate(
  //         ConsumeData.types.length, (index) => {ConsumeData.types[index]: 0.0});
  //
  //     for (var element in record) {
  //       var sum = 0.0;
  //       element.forEach((key, value) {
  //         for (var e in value) {
  //           var i = e.typeId - 1;
  //           percentage[i][ConsumeData.types[i]]! +=
  //               e.amount;
  //         }
  //       });
  //       percentage.add({element.keys.first: sum});
  //     }
  //
  //     state.percentage =
  //         await ApiConsume.getMonthTypePercent(date: "$date 00:00:00");
  //     state.percentage
  //         ?.sort((a, b) => a.values.first.compareTo(b.values.first));
  //   }
  // }

  Future<List<Map<String, double>>> getTypeTop4(String date) async {
    // await getPercentage(date);
    // List<Map<String, double>> list = state.percentage!;
    // list = list.sublist(0, list.length > 4 ? 4 : list.length);
    // double sum = 0;
    // for (var e in list) {
    //   sum += e.values.first;
    // }
    // list.add({"其余": max((1 - sum).toPrecision(2), 0)});
    // list.sort((a, b) => b.values.first.compareTo(a.values.first));
    // return list;

    List<Map<String, double>> result = [];
    var len = ConsumeData.types.length;
    // 4 random num from 0 to len
    var random = Random();
    var set = <int>{};
    while (set.length < 4) {
      set.add(random.nextInt(len));
    }
    // 4 random num from 0 to 1 and sum = 1
    var sum = 0.0;
    var list2 = <double>[];
    for (var i = 0; i < 5; ++i) {
      var v = random.nextDouble();
      list2.add(v);
      sum += v;
    }
    for (var i = 0; i < 5; ++i) {
      list2[i] /= sum;
    }
    for (var i = 0; i < 4; ++i) {
      result.add({ConsumeData.types[set.elementAt(i)]: list2[i]});
    }
    result.add({"其余": list2[4]});
    result.sort((a, b) => b.values.first.compareTo(a.values.first));
    return result;
  }

  // Future<List<Map<String, double>>> getTypeAll(String date) async {
  //   await getPercentage(date);
  //   return state.percentage!;
  // }

  Future<void> clear() async {
    state.percentage = null;
    state.date = null;
  }

  Future<double> _getOut({required String date}) async {
    return (await ApiConsume.getOut(type: "month", date: "$date 00:00:00"))
            ?.abs() ??
        0.0;
  }

  Future<double> _getIn({required String date}) async {
    return (await ApiConsume.getIn(type: "month", date: "$date 00:00:00"))
            ?.abs() ??
        0.0;
  }

  Future<List<double>> getOutIn({required String date}) async {
    return Future.wait([
      _getOut(
        date: date,
      ),
      _getIn(date: date)
    ]);
  }
}
