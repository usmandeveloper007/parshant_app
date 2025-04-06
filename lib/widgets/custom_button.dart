import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Size minimumSize;
  final Color backgroundColour;
  final Widget childWidget;
  final bool isButtonEnable;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.backgroundColour,
    required this.minimumSize,
    required this.childWidget,
    this.isButtonEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: minimumSize.width,
      height: minimumSize.height,
      decoration: BoxDecoration(
        color: isButtonEnable ? backgroundColour : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isButtonEnable ? onPressed : null,
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.green,
          child: Center(
            child: childWidget,
          ),
        ),
      ),
    );
  }
}
