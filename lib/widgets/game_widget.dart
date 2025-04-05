import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parshant_app/core/services/firebase_gamesData.dart';
import 'package:parshant_app/widgets/widgets.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  State<GameWidget> createState() => GameWidgetState();
}

class GameWidgetState extends State<GameWidget> {
  late Future<List<Map<String, dynamic>>> _gameDataFuture;

  @override
  void initState() {
    super.initState();
    refreshGames();
  }

  void refreshGames() {
    setState(() {
      _gameDataFuture = SaveData.syncFirebaseToSQLite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _gameDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return   Center(
            child: Text(
              "No Games",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.h,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              String date =
                  FormatedDate.formattedDateTime(data[index]["betDate"]);
              return GameCard(
                afterResult: data[index]["afterResult"] == 1 ? true : false,
                afterBetClose: data[index]["changeSystem"] == 1 ? true : false,
                gameName: data[index]["gameName"].toString(),
                resultTime: data[index]["resultTime"].toString(),
                betCloseTime: data[index]["betCloseTime"].toString(),
                betStartTime: data[index]["betStartTime"].toString(),
                lastResult: data[index]["lastResult"].toString(),
                date: date,
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

