import 'package:account/app/data/entity/book.dart';
import 'package:account/app/data/net/api_book.dart';
import 'package:get/get.dart';

import '../../../data/entity/consume.dart';
import 'my_book_state.dart';

class MyBookLogic extends GetxController {
  final MyBookState state = MyBookState();

  Future<List<Book>> getAllBook() async {
    return await ApiBook.getBook();
  }

  Future<bool> addBook(String bookName) async {
    return await ApiBook.addBook(bookName);
  }

  Future<bool> deleteBook(Book book) async {
    return await ApiBook.deleteBook(book);
  }

  Future<List<ConsumeData>> getBookRecord(num ledgerId) async {
    return await ApiBook.getBookRecord(ledgerId);
  }
}
