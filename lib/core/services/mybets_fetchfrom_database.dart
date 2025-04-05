import 'package:parshant_app/core/utils/database/database_helper.dart';
import 'package:parshant_app/models/mybets_model.dart';

import 'firebase_gamesData.dart';

class MYBetFetchFromDataBase {
  static DatabaseHelper dbClass = DatabaseHelper.instance;

  static Future<List<MyBet>> fetchDataFromDatabase() async {
    var db = await dbClass.getDb();

    List<Map<String, dynamic>> data = await db.query("MyBets");

    print("SqLite se fetched data : $data");

    List<MyBet> myBetData = [];

    for (var betData in data) {
      myBetData.add(MyBet.fromMap(betData));
    }
    return myBetData;
  }

  // date Wise filter My bet

  static Future<List<DateWiseFilterMyBet>> dateWiseFetchBet() async {
    List<MyBet> fetchMyBet = await fetchDataFromDatabase();

    List<String> uniqueDate = [];
    List<DateWiseFilterMyBet> dateWiseBet = [];

    for (var mybet in fetchMyBet) {
      String betDate = FormatedDate.formattedDateTime(mybet.betDate);
      print(betDate);
      if (!uniqueDate.contains(betDate)) {
        uniqueDate.add(betDate);
      }
    }

    print(uniqueDate);

    for (var date in uniqueDate) {
      List<MyBet> eachDateBet = [];

      for (var mybet in fetchMyBet) {
        String betDate = FormatedDate.formattedDateTime(mybet.betDate);
        if (betDate == date) {
          eachDateBet.add(mybet);
        }
      }

      dateWiseBet.add(DateWiseFilterMyBet(date: date, allBets: eachDateBet));
    }
    print(dateWiseBet);
    return dateWiseBet;
  }

  // location specific

  static Future<List<MyBet>> locationSpecific(
      {required String gameName}) async {
    List<MyBet> locationSpecificBet = [];
    Set<MyBet> mybetsSet = {}; // Use a Set to avoid duplicates

    List<DateWiseFilterMyBet> dateWiseBets = await dateWiseFetchBet();

    // Add all bets to the Set
    for (var bet in dateWiseBets) {
      mybetsSet.addAll(bet.allBets);
    }

    // Convert Set back to List (optional, if you need a List)
    List<MyBet> mybets = mybetsSet.toList();

    mybets.sort((a, b) => b.betDate.compareTo(a.betDate));

    print(mybets);

    // Filter based on gameName
    for (var mylocation in mybets) {
      if (mylocation.gameName.trim() == gameName.trim()) {
        locationSpecificBet.add(mylocation);
      }
    }

    print(locationSpecificBet);


    return locationSpecificBet;
  }
}
