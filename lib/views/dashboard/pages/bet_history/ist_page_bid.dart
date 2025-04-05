import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/Appfont.dart';
import 'slip_page.dart';

class IstPageBid extends StatefulWidget {
  final int locationValue ;
  const IstPageBid({super.key , required this.locationValue });

  @override
  State<IstPageBid> createState() => _IstPageBidState();
}

class _IstPageBidState extends State<IstPageBid> {
  final List<String> upperPartList = [
    "Faridabad",
    "Gaziyabad",
    "Gali",
    "Disawar",
  ];

  final ScrollController scrollController = ScrollController();
  int tapIndex = 0;

  @override
  void initState() {
     tapIndex = widget.locationValue ;
    super.initState();
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          upperPart(),
          Expanded(child: SlipPage(locationName: upperPartList[tapIndex].trim())),

        ],
      ),
    );
  }

  Widget upperPart() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: upperPartList.length,
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                tapIndex = index;
              });

              scrollController.animateTo(
                index * 150.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Row(
              children: [
                const SizedBox(width: 5),
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: tapIndex == index ? Colors.green : Colors.transparent,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(
                      upperPartList[index],
                      style: tapIndex == index
                          ? AppTextStyles.fontSize18(color: Colors.white)
                          : AppTextStyles.fontSize18(),
                    ),
                  ),
                ),
                const SizedBox(width: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}

