class DateWiseFilterMyBet {
  String date;
  List<MyBet> allBets;

  DateWiseFilterMyBet({required this.date, required this.allBets});
}

class MyBet {
  String userId;
  String resultDate;
  int betDate;
  String gameName;
  String status;
  String numbers;
  num totalAmount;

  MyBet(
      {required this.userId,
      required this.totalAmount,
      required this.resultDate,
      required this.betDate,
      required this.status,
      required this.gameName,
      required this.numbers});

  factory MyBet.fromMap(Map<String, dynamic> map) {
    return MyBet(
        userId: map["userId"] ?? "unKnown",
        status: map["status"] ?? "unKnown2",
        totalAmount: map["totalAmount"] ?? 0,
        resultDate: map["resultDate"] ?? "unknown3",
        gameName: map["gameName"] ?? "unknown4",
        betDate: map["betDate"] ?? 1,
        numbers: map["numbers"] ?? "unknown5");
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "betDate": betDate,
      "resultDate": resultDate,
      "gameName": gameName,
      "numbers": numbers,
      "status": status,
      "totalAmount": totalAmount,
    };
  }
}

