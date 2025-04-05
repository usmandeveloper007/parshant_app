import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:parshant_app/core/utils/shared_prefrences.dart';
import 'package:parshant_app/views/dashboard/dashboard.dart';
import '../constants/constants.dart';
import 'mybets_firebase_to_database.dart';

void placeBet(
    {required BuildContext context,
    required num amount,
    required String gameName,
    required List<dynamic> chooseNumberList,
    required String date}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BetStatusDialog(
        amount: amount,
        gameName: gameName,
        chooseNumberList: chooseNumberList,
        date: date,
      );
    },
  );
}

class BetStatusDialog extends StatefulWidget {
  final num amount;
  final String gameName;
  final List<dynamic> chooseNumberList;
  final String date;

  const BetStatusDialog(
      {required this.amount,
      required this.chooseNumberList,
      required this.date,
      required this.gameName,
      super.key});

  @override
  BetStatusDialogState createState() => BetStatusDialogState();
}

class BetStatusDialogState extends State<BetStatusDialog> {
  String status = "Wait...";
  Color statusColor = Colors.blue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    placeBet();
  }

  void placeBet() async {
    try {
      final HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable("placeBet");
      String? id = await SharedPreferencesHelper.getValue();
      id.toString().trim();
      await callable.call({
        "userId": id,
        "gameName": widget.gameName.trim(),
        "numbers": widget.chooseNumberList,
        "date": widget.date,
        "totalAmount": widget.amount,
      });

      setState(() {
        status = "Successful ✅";
        statusColor = Colors.green;
        isLoading = false;
      });

      // new data jo sucessfull h usko add kr rhe h sahi h

      MyBetsFirebaseToDatabase.addData();


      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard(
                    navigationIndex: 1,
                    locationValue: gameNameConvertIndex(
                      widget.gameName.trim(),
                    ),
                  )), (route) => false);
    } catch (e) {
      String errorMessage = "Something went wrong!";
      if (e is FirebaseFunctionsException) {
        errorMessage = e.message ?? "Unknown error occurred";
      }

      setState(() {
        status = "Failed ❌\n$errorMessage";
        statusColor = Colors.red;
        isLoading = false;
      });

      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pop(); // Dialog close after error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(
              status,
              style: AppTextStyles.fontSize20(color: statusColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  int gameNameConvertIndex(String gameName) {
    if (gameName == "Faridabad") {
      return 0;
    } else if (gameName == "Gaziyabad") {
      return 1;
    } else if (gameName == "Gali") {
      return 2;
    } else if (gameName == "Disawar") {
      return 3;
    } else {
      print("condition not match");
      return 0;
    }
  }

}

