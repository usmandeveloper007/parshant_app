import 'package:flutter/material.dart';

import 'package:parshant_app/core/constants/constants.dart';

class TabHeader {
  static Widget buildHeader({required String text1, required String text2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1, style: AppTextStyles.fontSize25().copyWith(fontSize: 30)),
          Text(text2, style: AppTextStyles.fontSize18()),
        ],
      ),
    );
  }
}
