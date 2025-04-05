import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parshant_app/core/services/mybets_firebase_to_database.dart';
import 'package:parshant_app/providers/balance_provider.dart';
import 'package:parshant_app/widgets/drawer.dart';
import 'package:parshant_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'pages/bet_history/ist_page_bid.dart';
import 'pages/chart_screen/chart_screen.dart';
import 'pages/contact_page/contact_page.dart';
import 'pages/location_screen/location_screen.dart';
import 'pages/wallet/ist_wallet_page.dart';

class Dashboard extends StatefulWidget {
  final int navigationIndex;
  final int locationValue;

  const Dashboard({
    super.key,
    this.navigationIndex = 0,
    this.locationValue = 0,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late int _selectedIndex;
  late int value;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.navigationIndex;
    value = widget.locationValue;

    screens = [
      const LocationScreen(),
      IstPageBid(locationValue: value),
      const IstWalletPage(),
      const ContactPage(),
      const ChartScreenIst(),
    ];

    Future.microtask(() {
      dataBet();
      Provider.of<BalanceProvider>(context, listen: false).fetchBalance();
    });
  }

  Future<void> dataBet() async {
    try {
      await MyBetsFirebaseToDatabase.syncFirebaseToSQLite();
    } catch (e) {
      print("❌ Data Sync Error: $e");
    }
  }

  final List<Widget> items = [
    Icon(Icons.home, size: 30.sp, color: Colors.white),
    Icon(Icons.receipt, size: 30.sp, color: Colors.white),
    Icon(Icons.account_balance_wallet, size: 30.sp, color: Colors.white),
    Icon(Icons.phone, size: 30.sp, color: Colors.white),
    Icon(Icons.add_chart, size: 30.sp, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          setState(() {
            _selectedIndex = 0;
          });
        }
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: const CustomAppBar(text: "Parshant App"),
        body: screens[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          color: Colors.blue,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.blueGrey,
          items: items,
          index: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
        ),
      ),
    );
  }
}
