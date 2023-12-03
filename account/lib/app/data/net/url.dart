// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo4LCJleHAiOjE3MDE4NTQzMTUsImlhdCI6MTcwMTI0OTUxNSwiaXNzIjoicnVuRnp1In0.j-slB-3XshG9Zf3fgw-5vQNEl3wEUab_0mVCWXGdm-Q

// s49neujkg.hn-bkt.clouddn.com/8/ticket_receipt_acg_0.jpg

class Url {
  // static String baseUrl = "http://43.136.122.18:8087";
  // static String baseUrl2 = "";

  // user1
  static String signUp = "/auth/register/pwd";
  static String login = "/auth/login/pwd";

  // static String user = "/user";
  // static String avatar = "https://gorsonpy-bucket.oss-cn-beijing.aliyuncs.com/";
  static String logout = "/user/logout";

  // img
  // static String uploadImg = "/api/file";
  // static String modify = "/api/dewarp";
  // static String recognizeImg = "/api/common_receipt";
  static String recognizeImg = "/api/shop_receipt";

  // guardian
  static String code = "/api/guardianship/code";

  // consumption
  static String addRecord = "/api/consumption";

  static String dayRemain = "/api/consumption/day/balance"; // 日余
  static String dayOut = "/api/consumption/day/out"; // 日支出
  static String dayIn = "/api/consumption/day/in"; // 日收入
  static String dayRecord = "/api/consumption/day"; // 日记录

  static String monthRemain = "/api/consumption/balance/month";
  static String monthOut = "/api/consumption/out/month/sum";
  static String monthIn = "/api/consumption/in/month/sum";
  static String monthRecord = "/api/consumption/month";

  static String yearRemain = "/api/consumption/balance/year";
  static String yearOut = "/api/consumption/out/year/sum";
  static String yearIn = "/api/consumption/in/year/sum";
  static String yearRecord = "/api/consumption/year";

  static String allRemain = "/api/consumption/sum/balance";
  static String allOut = "/api/consumption/out/sum";
  static String allIn = "/api/consumption/in/sum";
  static String allRecord = "/api/consumption";

  static String recordMap = "/api/consumption/month/map";
  static String rangeRecordMap = "/api/consumption/range/map";
  static String rangeOut = "/api/consumption/range/out";
  static String rangeIn = "/api/consumption/range/in";
  static String upSound = "/api/speech_recog";

  // static String monthType = "/api/type/analysis/month";

  // static String thirtyOutMoney = "/api/consumption/last/month/analysis";

  // book
  static String book = "/api/ledger";
  static String bookRecord = "/api/ledger/consumption";

  // goal
  static String goal = "/api/goal";
  static String goalRecord = "/api/goal/record";

  // multi_book
  static String multiBook = "/api/multiLedger";
  static String multiBookRecord = "/api/multiLedger/consumption";
  static String multiBookUser = "/api/multiLedger/user";
  static String multiBookBalance = "/api/multiLedger/balance";
}
