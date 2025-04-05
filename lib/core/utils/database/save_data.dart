// import 'package:parshant_app/core/services/services.dart';
// import 'package:parshant_app/core/utils/database/database_helper.dart';
// import 'package:sqflite/sqflite.dart';
//
// class SaveData {
//   static Future<bool> isDatabaseEmpty() async {
//     final db = await DatabaseHelper.instance.getDb();
//     List<Map<String, dynamic>> result = await db.query('gamesData');
//     return result.isEmpty; // ✅ Agar empty hai to true return karega
//   }
//
//   static Future<void> syncFirebaseToSQLite() async {
//     final db = await DatabaseHelper.instance.getDb();
//     bool isEmpty = await isDatabaseEmpty();
//
//     if (isEmpty) {
//       print("🔄 SQLite empty hai, Firebase se fetch kar rahe hain...");
//
//       List<Map<String, dynamic>> firebaseData =
//           await FirebaseGamesData.firebaseGames();
//
//       for (var game in firebaseData) {
//         await db.insert(
//           'gamesData',
//           {
//             'gameName': game['GameName'],
//             'betStartTime': game['Bet Start Time'],
//             'betCloseTime': game['Bet Close Time'],
//             'lastResult': game['Last Result'],
//             'resultTime': game['Result Time'],
//             'afterResult': game['afterResult'] == true ? 1 : 0,
//             'changeSystem': game['changeSystem'] == true ? 1 : 0,
//             // 'timeresult': game['timeresult'],
//           },
//           conflictAlgorithm:
//               ConflictAlgorithm.ignore, // ✅ Duplicate avoid karega
//         );
//       }
//
//       print("✅ Firebase ka data SQLite me insert ho gaya!");
//     } else {
//       print("✅ SQLite me data pehle se hai, Firebase fetch trigger nahi hoga.");
//     }
//   }
//
//   // fetch data
//
//   static Future<List<Map<String, dynamic>>> fetchGamesFromSqflite() async {
//     final db = await DatabaseHelper.instance.getDb();
//     List<Map<String, dynamic>> games = await db.query('gamesData');
//     return games;
//   }
//
//   static Future<void> loadGames() async {
//     List<Map<String, dynamic>> gameslist = [];
//     gameslist = await fetchGamesFromSqflite();
//     print("Games data : $gameslist");
//   }
// }
//
