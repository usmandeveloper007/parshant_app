import 'package:flutter/material.dart';
import 'package:parshant_app/providers/balance_provider.dart';



import 'package:provider/provider.dart';

import 'deposit/amount_add.dart';
import 'deposit/withdrawal/withdrawal_add_amount.dart';

class IstWalletPage extends StatelessWidget {
  const IstWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Consumer<BalanceProvider>(
                builder: (context, balanceProvider, child) {
              return Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
                child: Center(
                    child: Text(
                  "Total Amount : ₹${balanceProvider.balance}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            fundCard(
              context: context,
              leadingIcon: Icons.add_card_outlined,
              titleText: "Deposit Money",
              subtitleText: "You can add money to your wallet",
              widgetNumber: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            fundCard(
              context: context,
              leadingIcon: Icons.account_balance,
              titleText: "Withdraw Money",
              subtitleText: "You can withdraw winnings",
              widgetNumber: 2,
            ),
            const SizedBox(
              height: 10,
            ),



          ],
        ),
      ),
    );
  }

  Widget fundCard({
    required IconData leadingIcon,
    required String titleText,
    required String subtitleText,
    required int widgetNumber,
    required BuildContext context,
  }) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Material(
            color: Colors.transparent ,
            child: InkWell(
              onTap: () {
                if (widgetNumber == 1) {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCashPart1()));
                }

                else if(widgetNumber == 2){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawalAddAmount()));
                }

              },
              borderRadius: BorderRadius.circular(10),
              child: ListTile(
                leading: Icon(
                  leadingIcon,
                  size: 30,
                  color: Colors.red,
                ),
                title: Text(
                  titleText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(subtitleText),
                trailing: InkWell(
                  onTap: () {
                    if (widgetNumber == 1) {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddCashPart1()));
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}











