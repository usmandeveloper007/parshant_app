import 'package:flutter/material.dart';
import 'package:parshant_app/core/services/firebase_fetchchart.dart';
import 'package:parshant_app/core/services/firebase_gamesData.dart';

class ChartScreenIst extends StatelessWidget {
  const ChartScreenIst({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: FutureBuilder(
        future: FirebaseChart.fetchChart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          }
          if (snapshot.hasData) {
            var data = snapshot.data;

            return Column(
              children: [
                // *Header (Fixed at top)*
                buildTableHeader(),

                // *Scrollable ListView*
                Expanded(
                  child: ListView.builder(
                    // reverse: true, // *Sabse niche ka data pehle dikhega*
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      var timestamp = data[index]['Date'];
                      String date = FormatedDate.formattedDateTime(timestamp);

                      return Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(1.4),
                          1: FlexColumnWidth(1.3),
                          2: FlexColumnWidth(1.3),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            children: [
                              tableCell(date),
                              tableCell("${data[index]['Faridabad'] ?? ''}"),
                              tableCell("${data[index]['Gaziyabad'] ?? ''}"),
                              tableCell("${data[index]['Gali'] ?? ''}"),
                              tableCell("${data[index]['Disawar'] ?? ''}"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  // *Header Widget*
  Widget buildTableHeader() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(1.4),
        1: FlexColumnWidth(1.3),
        2: FlexColumnWidth(1.3),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.orange),
          children: [
            tableCell('DATE', isHeader: true),
            tableCell('Faridabad', isHeader: true),
            tableCell('Gaziyabad', isHeader: true),
            tableCell('Gali', isHeader: true),
            tableCell('Disawar', isHeader: true),
          ],
        ),
      ],
    );
  }

  // *Reusable Table Cell*
  Widget tableCell(String text, {bool isHeader = false}) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      color: isHeader ? Colors.orange : null,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
