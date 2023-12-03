import 'package:account/app/data/entity/book.dart';
import 'package:account/app/utils/date_util.dart';
import 'package:dio/dio.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';
import '../entity/consume.dart';
import 'dio.dart';
import 'url.dart';

class ApiBook {
  static Future<List<Book>> getBook() async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil()
        .get(Url.book, options: Options(headers: {"token": token}));
    List<Book> list = [];
    if (response?.data["code"] == 0) {
      response?.data["data"]["list"].forEach((v) {
        list.add(Book.fromJson(v));
      });
    }
    return list;
  }

  static Future<bool> addBook(String bookName) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(Url.book,
        data: {
          "ledgerName": bookName,
          "createTime": DateUtil.getFormattedDateTime(DateTime.now()),
          "updateTime": DateUtil.getFormattedDateTime(DateTime.now()),
        },
        options: Options(
            headers: {"token": token}, contentType: "application/json"));
    if (response?.data["code"] == 0) {
      return true;
    }
    return false;
  }

  static Future<bool> deleteBook(Book book) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().delete(
      Url.book,
      map: book.toJson(),
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

  // getBookRecord
  static Future<List<ConsumeData>> getBookRecord(num ledgerId) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().get(Url.bookRecord,
        map: {"ledgerId": ledgerId},
        options: Options(headers: {"token": token}));
    List<ConsumeData> list = [];
    if (response?.data["code"] == 0) {
      response?.data["data"]["list"].forEach((v) {
        print(v);
        var c = ConsumeData.fromJson(v);
        list.add(c);
        print(list.length);
      });
    }
    print("getBookRecord");
    print(list);
    return list;
  }

  // addBookRecord
  static Future<bool> addBookRecord(num ledgerId, num consumptionId) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(
      Url.bookRecord,
      query: {"ledgerId": ledgerId, "consumptionId": consumptionId},
      options:
          Options(headers: {"token": token}, contentType: "application/json"),
    );
    print("addBookRecord");
    print(response?.data);
    if (response?.data["code"] == 0) {
      return true;
    }
    return false;
  }
}
