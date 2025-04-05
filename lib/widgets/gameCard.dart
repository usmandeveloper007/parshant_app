import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parshant_app/widgets/vertical_space.dart';
import 'package:parshant_app/widgets/widgets.dart';

class GameCard extends StatelessWidget {
  final String gameName;
  final String betCloseTime;
  final String betStartTime;
  final String lastResult;
  final String resultTime;

  final String date;
  final bool afterBetClose;
  final bool afterResult;

  const GameCard(
      {super.key,
        required this.afterResult,
        required this.gameName,
        required this.resultTime,
        required this.betCloseTime,
        required this.afterBetClose,
        required this.betStartTime,
        required this.date,
        required this.lastResult});

  @override
  Widget build(BuildContext context) {
    return gameCard(
        gameName: gameName,
        result: lastResult,
        resultTime: resultTime,
        betCloseTime: betCloseTime,
        context: context,
        betStartTime: betStartTime);
  }

  Widget gameCard(
      {required String gameName,
        required String result,
        required String betCloseTime,
        required String betStartTime,
        required String resultTime,
        required BuildContext context}) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Container(


            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              children: [
                const VerticalSpace(),
                gameName1(gameName: gameName),
                VerticalSpace(
                  height: 5.h,
                ),
                result1(result: result, betCloseStatus: afterBetClose),
                VerticalSpace(
                  height: 5.h,
                ),
                nextResultTime1(
                    nextResultTime: resultTime,
                    betTime: betCloseTime,
                    betCloseStatus: afterBetClose),
                VerticalSpace(
                  height: 5.h,
                ),
                betStatus1(betStatus: afterBetClose),
                VerticalSpace(
                  height: 10.h,
                ),
                customButton1(
                    afterResult: afterResult,
                    context: context,
                    betStatus: afterBetClose,
                    gameName: gameName,
                    resultTime: resultTime),
                VerticalSpace(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ),
        VerticalSpace(
          height: 10.h,
        ),
      ],
    );
  }

  Widget gameName1({required String gameName}) {
    return Center(
      child: Text(
        gameName,
        style:   TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
    );
  }

  Widget result1({required String result, required bool betCloseStatus}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          betCloseStatus == false ? "Last Result" : "Result",
          style : TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
         SizedBox(
          width: 10.w,
        ),
         Icon(
          Icons.arrow_forward,
          color: Colors.red,
          size: 30.sp,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          betCloseStatus == false ? result.toString() : "Wait",
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }

  // abhi ke itna hi thik h done h baat yhe okay h
  Widget nextResultTime1(
      {required String nextResultTime,
        required String betTime,
        required bool betCloseStatus}) {
    return Column(
      children: [
        Text(
          'Result Time -- ${nextResultTime.toString()}',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          afterResult == false
              ? 'Bet Close Time --  $betTime'
              : "Bet Start Time -- Tommrrow,11 A.m",
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }

  Widget betStatus1({required bool betStatus}) {
    return Text(
      afterResult == true ? "Bet Closed !! 😥" : "Betting is Running Now 😊 ",
      style: TextStyle(
          color: afterResult == true ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 20),
    );
  }

  Widget customButton1(
      {required bool betStatus,
        required bool afterResult,
        required String gameName,
        required BuildContext context,
        required String resultTime}) {
    return CustomButton(
      onPressed: () {
        afterResult == true
            ? showBetCloseDialog(context)
            : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JodiGameScreen(
                  gameName: gameName,
                  resulTime: date,
                )));
      },
      backgroundColour: Colors.blue,
      minimumSize: Size(250.w, 40.h),
      childWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          afterResult == true
              ? const Icon(
            Icons.lock,
            color: Colors.red,
          )
              : const Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            afterResult == true ? "Bet Closed" : "Play Game",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  void showBetCloseDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.red,
                ),
                VerticalSpace(
                  height: 10.h,
                ),
                const Text("Betting Closed"),
              ],
            ),
            content: Text(
              'Betting is now closed for this round . Please play another games.',
              softWrap: true,
              style: TextStyle(fontSize: 15.sp),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          );
        });
  }
}

