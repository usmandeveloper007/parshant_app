import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/constants.dart';



class CustomTabBar {

  static Widget buildTabBar({required TabController mTabController}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 320,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: mTabController,
            indicator: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.textBodyPart2,
            dividerColor: AppColors.textBodyPart4,
            tabs: [
              buildTab("Phone", Icons.phone_android),
              buildTab("Email", Icons.email),
            ],
          ),
        ),
      ),
    );
  }



  static Widget buildTab(String label, IconData icon) {
    return Tab(
      height: 55,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(label,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }


}
