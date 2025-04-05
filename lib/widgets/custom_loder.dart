import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/constants.dart';



class CustomLoader extends StatelessWidget {

  const CustomLoader({super.key });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          "Please Wait",
          style: AppTextStyles.fontSize20(
              color: Colors.white),
        ),
      ],
    );
  }
}