
import '../../data/entity/consume.dart';

class HomeState {
  String? start;
  String? end;
  List<Map<String, List<ConsumeData>>>? record;
  bool isMonth = false;
  double outM = 0.0;
  double inM = 0.0;

  HomeState() {
    ///Initialize variables
    ///

  }
}
