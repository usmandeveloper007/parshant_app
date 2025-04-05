import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletTextField extends StatelessWidget {
  final TextEditingController textEditingController ;
  final ValueChanged<String>  onChanged;
  final String labelText ;
  final int maxLength ;
  const WalletTextField({super.key , required this.textEditingController , required this.onChanged , required this.labelText ,  this.maxLength = 5});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller:  textEditingController,
        onChanged:  onChanged,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,

        ],
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          counterText: "", // Counter ko remove kar diya
        ),
        maxLength: maxLength, // Length limit rakhi hai
      ),
    ) ;
  }
}

