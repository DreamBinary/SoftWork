class Url {
  // user
  static String sendSms = "/auth/register/mobile";
  static String signUp = "/auth/register/mobile";
  static String login = "/auth/login/pwd";
  static String user = "/user";
  static String avatar = "https://gorsonpy-bucket.oss-cn-beijing.aliyuncs.com/";
  static String logout = "/user/logout";

  // img
  static String uploadImg = "/file";
  static String modify = "/api/dewarp";
  static String recognizeImg = "/api/common_receipt";
  static String recognizeImg2 = "/api/shop_receipt";

  // money
  static String ableMon = "/api/exchange_rate/configs";
  static String exchange = "/api/exchange_rate/list";

  // guardian
  static String code = "/api/guardianship/code";

  // consumption
  static String addRecord = "/api/consumption";

  static String dayRemain = "/api/consumption/balance/day";
  static String dayOut = "/api/consumption/day/out";
  static String dayIn = "/api/consumption/day/in";
  static String dayRecord = "/api/consumption/day";

  static String monthRemain = "/api/consumption/balance/month";
  static String monthOut = "/api/consumption/out/month/sum";
  static String monthIn = "/api/consumption/in/month/sum";
  static String monthRecord = "/api/consumption/month";

  static String yearRemain = "/api/consumption/balance/year";
  static String yearOut = "/api/consumption/out/year/sum";
  static String yearIn = "/api/consumption/in/year/sum";
  static String yearRecord = "/api/consumption/year";

  static String allRemain = "/api/consumption/balance";
  static String allOut = "/api/consumption/out/sum";
  static String allIn = "/api/consumption/in/sum";
  static String allRecord = "/api/consumption";

  static String recordMap = "/api/consumption/month/map";
  static String rangeRecordMap = "/api/consumption/range/map";
  static String rangeOut = "/api/consumption/range/out";
  static String rangeIn = "/api/consumption/range/in";

  static String upSound = "/api/speech_recog";

  static String monthType = "/api/type/analysis/month";

  static String thirtyOutMoney = "/api/consumption/last/month/analysis";
}
