

void main(){

  var k = DateTime.parse("2021-01-01 00:00:00");
  // k before 30 days
  var kk = k.subtract(Duration(days: 30));
  print(kk);
}