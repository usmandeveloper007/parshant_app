import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/Appfont.dart';
import 'package:parshant_app/core/services/firebase_gamesData.dart';
import 'package:parshant_app/core/services/mybets_fetchfrom_database.dart';
import 'package:parshant_app/models/mybets_model.dart';
import 'package:parshant_app/views/dashboard/pages/bet_history/bidding_histroy.dart';

class SlipPage extends StatelessWidget {
  const SlipPage({super.key, required this.locationName});

  final String locationName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MYBetFetchFromDataBase.locationSpecific(gameName: locationName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            print('future builder Error :${snapshot.error}');
            return const Text("Something went wrong, try again");
          }

          if (snapshot.hasData) {
            var getdata = snapshot.data!;

            if (getdata.isEmpty) {
              return const Center(child: Text("No History"));
            }

            // 🔥 Unique Dates Extract Karo
            List<String> uniqueDates = getdata
                .map((bet) => FormatedDate.formattedDateTime(bet.betDate))
                .toSet()
                .toList();

            return SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: uniqueDates
                    .length, // ✅ Ab sirf unique dates ke liye chalega
                itemBuilder: (context, index) {
                  String betDate = uniqueDates[index];

                  // ✅ Sirf iss date ke bets lo
                  List<MyBet> betsForDate = getdata
                      .where((bet) =>
                          FormatedDate.formattedDateTime(bet.betDate) ==
                          betDate)
                      .toList();

                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: Text(
                            betDate,
                            style: AppTextStyles.fontSize20(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: betsForDate.length,
                        itemBuilder: (context, childIndex) {
                          var betdata = betsForDate[childIndex];
                          List<dynamic> myDecodedList =
                              jsonDecode(betdata.numbers);
                          return BiddingCard(
                            betDate:
                                FormatedDate.formattedDateTime(betdata.betDate),
                            gameName: betdata.gameName,
                            totalAmount: betdata.totalAmount.toString(),
                            betStatus: betdata.status,
                            date: betdata.resultDate,
                            selectedNumber: myDecodedList,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return Container();
        });
  }
}


