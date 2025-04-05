import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parshant_app/core/constants/Appfont.dart';
import 'package:parshant_app/core/services/bet_place.dart';
import 'package:parshant_app/core/utils/device_height_width.dart';
import 'package:parshant_app/widgets/custom_button.dart';

class ShowNumberPage extends StatelessWidget {
  final String gameName;
  final List<dynamic> chooseNumberList;
  final String date;
  final num totalAmount;
  final bool showStack;

  const ShowNumberPage(
      {super.key,
      required this.totalAmount,
      required this.gameName,
      required this.chooseNumberList,
      required this.showStack,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(children: [
                _buildGameHeader(),
                const SizedBox(
                  height: 10,
                ),
                _buildTableHeader(),
                _buildNumberList(),
              ]),
            ),
            _buildNextWidget(context),
          ],
        ),
      ),
    );
  }

  // Game header 1st part of column

  Widget _buildGameHeader() {
    return Container(
      color: Colors.red,
      height: ScreenDimensions.height * 0.0659,
      width: double.infinity,
      child: Center(
          child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          "$gameName - $date",
          style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      )),
    );
  }

  // Table Header 2nd part of column
  Widget _buildTableHeader() {
    return SizedBox(
      height: ScreenDimensions.height * 0.0439,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Numbers",
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Text(
            "Amount",
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberList() {
    return Expanded(
      child: ListView.builder(
          itemCount: chooseNumberList.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return SizedBox(
              height: ScreenDimensions.height * 0.0769,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${chooseNumberList[index]["index"]}",
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "₹${chooseNumberList[index]["value"]}",
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  // next widget

  Widget _buildNextWidget(BuildContext context) {
    return showStack == true
        ? Positioned(
            left: 0,
            right: 0,
            bottom: 10, // Position at the bottom with some margin
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: ScreenDimensions.height * 0.0494,
                  width: ScreenDimensions.width * 0.3795,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.red,
                      )),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      children: [
                        const Text("Total"),
                        Text(
                          "₹$totalAmount",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                _buildBottomActions(context),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _buildBottomActions(BuildContext context) {
    return CustomButton(
        onPressed: () async {
          placeBet(
              context: context,
              gameName: gameName,
              chooseNumberList: chooseNumberList,
              date: date,
              amount: totalAmount);
        },
        backgroundColour: Colors.green,
        minimumSize: Size(
            ScreenDimensions.width * 0.3795, ScreenDimensions.height * 0.0494),
        childWidget: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Confirm",
            style: AppTextStyles.fontSize20(color: Colors.white),
          ),
        ));
  }
}
