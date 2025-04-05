
class NumberModel {
  String gameName;
  String totalAmount;
  String betStatus;
  var date;
  List<dynamic> selectedNumber;

  NumberModel(
      {required this.totalAmount,
      required this.betStatus,
      this.date,
      required this.selectedNumber,
      required this.gameName});

  Map<String, dynamic> toJson() {
    return {
      "gameName": gameName,
      "totalAmount": totalAmount,
      "date": date,
      "selectedNumbers": selectedNumber,
      "betStatus": betStatus,
    };
  }

  factory NumberModel.fromMap(Map<String, dynamic> map) {
    return NumberModel(
      totalAmount: map["totalAmount"],
      betStatus: map["betStatus"], //
      date: map["date"],
      selectedNumber: map["selectedNumbers"],
      gameName: map["gameName"],
    );
  }
}

