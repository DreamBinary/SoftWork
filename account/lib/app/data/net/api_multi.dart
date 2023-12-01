import 'package:account/app/data/entity/consume.dart';
import 'package:account/app/data/entity/multi_book.dart';
import 'package:account/app/utils/date_util.dart';
import 'package:dio/dio.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';
import 'dio.dart';
import 'url.dart';

class ApiMultiBook {
  static Future<List<MultiBook>> getMultiBook() async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil()
        .get(Url.multiBook, options: Options(headers: {"token": token}));
    List<MultiBook> list = [];
    if (response?.data["base"]["code"] == 0) {
      response?.data["data"]["list"].forEach((v) {
        list.add(MultiBook.fromJson(v));
      });
    }
    return list;
  }

  static Future<bool> addMultiBook(String bookName, String description) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(
      Url.multiBook,
      data: {
        "multiLedgerName": bookName,
        "description": description,
        "password": "123456",
        "modifyTime": DateUtil.getFormattedDateTime(DateTime.now()),
      },
      options: Options(
        headers: {"token": token},
        contentType: "application/json",
      ),
    );
    if (response?.data["code"] == 0) {
      return true;
    }
    return false;
  }

  static Future<List<String>> getMultiBookUser(num multiLedgerId) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().get(
      Url.multiBookUser,
      map: {"multiLedgerId": multiLedgerId},
      options: Options(
        headers: {"token": token},
        contentType: "application/json",
      ),
    );
    List<String> list = [];
    if (response?.data["base"]["code"] == 0) {
      response?.data["data"]["list"].forEach((v) {
        list.add(v["username"]);
      });
    }
    return list;
  }

  // /api/multiLedger/balance
  static Future<num> getMultiBookBalance(num multiLedgerId) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().get(
      Url.multiBookBalance,
      map: {"multiLedgerId": multiLedgerId},
      options: Options(
        headers: {"token": token},
        contentType: "application/json",
      ),
    );
    if (response?.data["base"]["code"] == 0) {
      return response?.data["data"]["balance"];
    }
    return 0;
  }

  // get multiBookRecord
  static Future<List<Map<String, List<ConsumeData>>>> getMultiBookRecord(
      num multiLedgerId) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().get(
      Url.multiBookRecord,
      map: {"multiLedgerId": multiLedgerId},
      options: Options(
        headers: {"token": token},
        contentType: "application/json",
      ),
    );
    List<Map<String, List<ConsumeData>>> list = [];

    // var response = await DioUtil().get(url,
    //     map: {"date": date}, options: Options(headers: {"token": token}));
    // print("getRecordMap");
    if (response?.data["base"]["code"] == 0) {
      var keys = response?.data["data"]["list"].keys.toList();
      List<dynamic> values = response?.data["data"]["list"].values.toList();
      int len = keys.length;
      for (int i = 0; i < len; ++i) {
        List<ConsumeData> cData = [];
        if (values[i].runtimeType != List) {
          continue;
        }
        for (var e in values[i]) {
          cData.add(ConsumeData.fromJson(e));
        }

        list.add({keys[i]: cData});
      }
    }
    return list;
  }

// static Future<bool> addBook(String bookName) async {
//   String token = MMKVUtil.getString(AppString.mmToken);
//   var response = await DioUtil().post(Url.book,
//       data: {
//         "ledgerName": bookName,
//         "createTime": DateUtil.getFormattedDateTime(DateTime.now()),
//         "updateTime": DateUtil.getFormattedDateTime(DateTime.now()),
//       },
//       options: Options(
//           headers: {"token": token}, contentType: "application/json"));
//   if (response?.data["code"] == 0) {
//     return true;
//   }
//   return false;
// }
//
// static Future<bool> deleteBook(Book book) async {
//   String token = MMKVUtil.getString(AppString.mmToken);
//   var response = await DioUtil().delete(
//     Url.book,
//     map: book.toJson(),
//     options: Options(
//       headers: {"token": token},
//       contentType: "application/json",
//     ),
//   );
//   if (response?.data["code"] == 0) {
//     return true;
//   }
//   return false;
// }
//
// // getBookRecord
// // todo
// static Future<List<ConsumeData>> getBookRecord(num ledgerId) async {
//   String token = MMKVUtil.getString(AppString.mmToken);
//   var response = await DioUtil().get(Url.bookRecord,
//       map: {"ledgerId": ledgerId},
//       options: Options(headers: {"token": token}));
//   List<ConsumeData> list = [];
//   if (response?.data["code"] == 0) {
//     response?.data["data"]["list"].forEach((v) {
//       list.add(ConsumeData.fromJson(v));
//     });
//   }
//   return list;
// }
}
