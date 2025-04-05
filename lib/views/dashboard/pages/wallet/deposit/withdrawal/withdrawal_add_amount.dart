import 'package:flutter/material.dart';
import 'package:parshant_app/views/dashboard/pages/wallet/deposit/linking_whtashpp.dart';
import 'package:parshant_app/views/dashboard/pages/wallet/wallet_text.dart';
import 'package:provider/provider.dart';
import 'package:parshant_app/core/constants/constants.dart';
import 'package:parshant_app/providers/balance_provider.dart';
import 'package:parshant_app/widgets/widgets.dart';

class WithdrawalAddAmount extends StatelessWidget {
  WithdrawalAddAmount({super.key});

  final TextEditingController enterAmountController = TextEditingController();
  final ValueNotifier<String> valueNotifierText = ValueNotifier<String>("");
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);
  double balance = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAppBar(context),
              const SizedBox(height: 30),
              _buildQuestionText(),
              const SizedBox(height: 5),
              _buildBalanceDisplay(),
              const SizedBox(height: 20),
              _buildAmountInputField(),
              _buildErrorMessage(),
              const SizedBox(height: 20),
              _buildContinueButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// 📌 *App Bar*
  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        children: [
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textBodyPart2,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Withdrawal Money",
            style: AppTextStyles.fontSize20(color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// 📌 *Question Text*
  Widget _buildQuestionText() {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(
          "How much do you want to Withdrawal?",
          style: AppTextStyles.fontSize20(),
        ),
      ),
    );
  }

  /// 📌 *Balance Display*
  Widget _buildBalanceDisplay() {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Consumer<BalanceProvider>(
          builder: (context, totalBalance, child) {
            if (totalBalance.balance.toString().isNotEmpty) {
              balance = double.parse(totalBalance.balance);
              return RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Current balance : ",
                    style: AppTextStyles.fontSize18()
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: "₹ ${totalBalance.balance}",
                    style: AppTextStyles.fontSize18(color: Colors.blue),
                  ),
                ]),
              );
            } else {
              return Text("XX", style: AppTextStyles.fontSize18());
            }
          },
        ),
      ),
    );
  }

  /// 📌 *Amount Input Field*
  Widget _buildAmountInputField() {
    return WalletTextField(
      textEditingController: enterAmountController,
      labelText: ' ₹ Enter Amount',
      maxLength: 7,
      onChanged: handleTextChange,
    );
  }

  /// 📌 *Error Message*

  Widget _buildErrorMessage() {
    return ValueListenableBuilder(
      valueListenable: valueNotifierText,
      builder: (context, value, child) {
        return Text(
          valueNotifierText.value,
          style: const TextStyle(color: Colors.red),
        );
      },
    );
  }

  /// 📌 *Continue Button (Enabled/Disabled)*

  Widget _buildContinueButton() {
    return ValueListenableBuilder(
      valueListenable: isButtonEnabled,
      builder: (context, isEnabled, child) {
        return CustomButton(
          onPressed: () {
            int? amount = int.tryParse(enterAmountController.text.toString());
            if (enterAmountController.text.isNotEmpty &&
                amount != null &&
                amount >= 500 &&
                amount <= balance) {
              // yha message dena h muje okay done h

              openWhatsApp(
                  "मुझे $amount रुपये का withdrawal लेना है।,कृपया तुरंत मेरा withdrawal दे।");
            }
          },
          backgroundColour: isEnabled ? Colors.blue : Colors.grey.shade500,
          minimumSize: const Size(280, 40),
          childWidget: Text(
            "Continue",
            style: AppTextStyles.fontSize18(color: Colors.white),
          ),
        );
      },
    );
  }

  /// 📌 *Text Change Handler with Button Logic*
  void handleTextChange(String text) {
    if (text.isEmpty) {
      valueNotifierText.value = "Please Enter Amount";
      isButtonEnabled.value = false;
    } else {
      int? amount = int.tryParse(text);
      if (amount == null) {
        valueNotifierText.value = "Correct Amount";
        isButtonEnabled.value = false;
      } else if (amount < 500) {
        valueNotifierText.value = "min ₹ 500";
        isButtonEnabled.value = false;
      } else if (amount >= balance) {
        valueNotifierText.value = "Insffucient Amount";
        isButtonEnabled.value = false;
      } else {
        valueNotifierText.value = " ";
        isButtonEnabled.value =
            true; // ✅ Button enable hoga agar amount >= 50 ho
      }
    }
  }
}

