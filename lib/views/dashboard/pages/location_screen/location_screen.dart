import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:parshant_app/providers/balance_provider.dart';
import 'package:parshant_app/views/dashboard/pages/wallet/deposit/amount_add.dart';
import 'package:parshant_app/views/rough_page/firestore_service.dart';
import 'package:parshant_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../wallet/deposit/withdrawal/withdrawal_add_amount.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GlobalKey<GameWidgetState> _gameWidgetKey;

  @override
  void initState() {
    super.initState();
    _gameWidgetKey = GlobalKey<GameWidgetState>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          strokeWidth: 3.sp,
          displacement: 100.h,
          color: Colors.black,
          onRefresh: () async {
            await FirestoreService.fetchFromCacheAndSync();
            _gameWidgetKey.currentState?.refreshGames();
            setState(() {});
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                _buildScrollingText(),
                SizedBox(height: 10.h),
                _buildWalletSection(context),
                SizedBox(height: 20.h),
                AutoSizeText(
                  "Games",
                  maxLines: 1, // Ek hi line me text aayega
                  style: TextStyle(fontSize: 25.sp),
                  minFontSize: 15, // Font size adjust hoga
                  overflow: TextOverflow.ellipsis, // Overflow handle karega
                ),
                GameWidget(key: _gameWidgetKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWalletSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0.w),
      child: Container(
        height: 150.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.blue,
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<BalanceProvider>(
                  builder: (context, balanceProvider, child) {
                    return AutoSizeText(
                      "Wallet Balance: ₹${balanceProvider.balance}",
                      maxLines: 1, // Ek hi line me rahega
                      minFontSize: 14, // Chhoti screen par size adjust hoga
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<BalanceProvider>(context, listen: false)
                        .fetchBalance();
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _buildWalletButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(context, "Add", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCashPart1()),
          );
        }),
        SizedBox(width: 10.w),
        _buildActionButton(context, "Withdrawal", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WithdrawalAddAmount()),
          );
        }),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return CustomButton(
      onPressed: onPressed,
      backgroundColour: Colors.green,
      minimumSize: Size(170.w, 45.h),
      childWidget: AutoSizeText(
        text,
        maxLines: 1, // Ek hi line me text aayega
        minFontSize: 14, // Adjust hoke chhoti screen pe bhi fit hoga
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildScrollingText() {
    return Container(
      height: 40.h,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: ScrollingText(),
    );
  }
}
