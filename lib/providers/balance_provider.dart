import 'package:flutter/cupertino.dart';
import 'package:parshant_app/core/services/firebase_fetch_total_balance.dart';


class BalanceProvider extends ChangeNotifier {
  String balance = "0";

  BalanceProvider() {
    fetchBalance();
  }

  Future<void> fetchBalance() async {
    balance = await FirebaseFetchTotalBalance.fetchBalance();
    notifyListeners();
  }
}
