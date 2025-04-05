import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:parshant_app/core/utils/device_height_width.dart';
import 'show_your_number_page/show_number_page.dart';

class BiddingCard extends StatelessWidget {
  final String gameName;
  final String  betDate;
  final String totalAmount;
  final String betStatus;
  final String date;
  final List<dynamic> selectedNumber;
  const BiddingCard(
      {super.key,
      required this.gameName,
      required this.totalAmount,
      required this.betStatus,
      required this.date,
      required this.betDate,
      required this.selectedNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // yha kre
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowNumberPage(
                          totalAmount: int.parse(totalAmount),
                          gameName: gameName,
                          chooseNumberList: selectedNumber,
                          showStack: false,
                          date: date)));
            },
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  AutoSizeText(
                    "Status : $betStatus",
                    maxLines: 1,
                    maxFontSize: 23,
                    minFontSize: 13,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,

                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // color: Colors.red,
                            width: ScreenDimensions.width*0.3,
                            child: const AutoSizeText(
                              "Game Name:",
                              maxLines: 1,
                              maxFontSize: 22,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            width: ScreenDimensions.width*0.27,
                            child: AutoSizeText(gameName,
                                maxLines: 1,
                                maxFontSize: 20,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            // color: Colors.red,
                            width: ScreenDimensions.width*0.3,
                            child: const AutoSizeText("Bet Date",
                                maxLines: 1,
                                maxFontSize: 22,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            // color: Colors.red,
                            width: ScreenDimensions.width*0.27,
                            child: AutoSizeText(betDate,
                                maxLines: 1,
                                maxFontSize: 20,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      // 2nd widget
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // color: Colors.red,
                          width: ScreenDimensions.width*0.3,
                            child: const AutoSizeText(
                              "TotalAmount:",
                              maxLines: 1,
                              maxFontSize: 22,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //,color: Colors.red,
                              width: ScreenDimensions.width*0.27,

                            child: AutoSizeText(
                              " ₹$totalAmount",
                              maxLines: 1,
                              maxFontSize: 20,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                           // color: Colors.red,
                            width: ScreenDimensions.width*0.3,
                            child: const AutoSizeText("Result Date",
                                maxLines: 1,
                                maxFontSize: 22,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                           Container(
                             // color: Colors.red,
                             width: ScreenDimensions.width*0.27,
                             child: AutoSizeText(date,
                                maxLines: 1,
                                 maxFontSize: 20,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                           ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

