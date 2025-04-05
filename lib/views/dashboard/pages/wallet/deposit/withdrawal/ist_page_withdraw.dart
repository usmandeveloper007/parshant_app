import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/constants.dart';
import 'package:parshant_app/providers/balance_provider.dart';
import 'package:parshant_app/views/dashboard/pages/wallet/wallet_text.dart';
import 'package:parshant_app/widgets/widgets.dart';

import 'package:provider/provider.dart';

class WithdrawCash extends StatelessWidget {
  WithdrawCash({super.key});

  final TextEditingController enterAmountController = TextEditingController();

  final ValueNotifier valueNotifierText = ValueNotifier<String>("");
  int matchBalance = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: double.infinity,
              color: AppColors.istBottomNavigatorIndexColor,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.textBodyPart2,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Withdraw Money",
                    style: AppTextStyles.fontSize20(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // SizedBox(
            //     width: double.infinity,
            //     child: Center(
            //         child: Text(
            //           "How much do you want to add ?",
            //           style: AppTextStyles.fontSize20(),
            //         ))),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Consumer<BalanceProvider>(
                  builder: (context, totalBalance, child) {
                    if (totalBalance.balance.toString().isNotEmpty) {
                      matchBalance = int.parse(totalBalance.balance);
                      return RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Current balance : ",
                            style: AppTextStyles.fontSize18()
                                .copyWith(fontWeight: FontWeight.normal)),
                        TextSpan(
                            text: "₹ ${totalBalance.balance}",
                            style:
                                AppTextStyles.fontSize18(color: Colors.blue)),
                      ]));
                    } else {
                      return Text("XX", style: AppTextStyles.fontSize18());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            WalletTextField(
              textEditingController: enterAmountController,
              labelText: ' ₹ Enter Amount',
              maxLength: 6,
              onChanged: handleTextChange,
            ),
            ValueListenableBuilder(
              valueListenable: valueNotifierText,
              builder: (context, value, child) {
                return Text(
                  valueNotifierText.value,
                  style: const TextStyle(color: Colors.red),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onPressed: () {
                  int? amount =
                      int.tryParse(enterAmountController.text.toString());
                  if (enterAmountController.text.isNotEmpty &&
                      amount != null &&
                      amount >= 1000 &&
                      matchBalance >= amount) {
                    // openWhatsApp(enterAmountController.text.toString().trim());
                  }
                },
                backgroundColour: AppColors.istBottomNavigatorIndexColor,
                minimumSize: const Size(280, 40),
                childWidget: Text(
                  "Continue",
                  style: AppTextStyles.fontSize18(color: Colors.white),
                )),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void handleTextChange(text) {
    if (text.isEmpty) {
      valueNotifierText.value = "Please Enter Amount";
    } else {
      int? amount = int.tryParse(text);
      if (amount == null) {
        valueNotifierText.value = "Correct Amount";
      } else if (amount < 1000) {
        valueNotifierText.value = "min ₹ 1000";
      } else {
        valueNotifierText.value = " ";
      }
    }
  }
}
