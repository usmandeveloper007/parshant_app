import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parshant_app/views/auth/log_in_screen.dart';
import 'package:parshant_app/views/dashboard/pages/wallet/deposit/amount_add.dart';
import 'package:parshant_app/views/feedback_page.dart';

import '../core/constants/constants.dart';
import '../core/utils/utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Drawer(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: ListView(
            children: [
              Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(
                      child: Text(
                    "Parshant App",
                    style: TextStyle(fontSize: 16.sp,color: Colors.white),
                  ))),
              ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                  size: 30,
                ),
                title: Text("Add money", style: TextStyle(fontSize: 12.sp)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCashPart1(),
                      ));
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.feed_outlined,
                  size: 30,
                ),
                title: Text("Feedback", style: TextStyle(fontSize: 12.sp)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const FeedbackPage()));
                },
              ),
              const SizedBox(
                height: 5,
              ),

              ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 30,
                ),
                title: Text("Logout", style: TextStyle(fontSize: 12.sp)),
                onTap: () {
                  dialogBox(context);
                },
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  // yha log out ka dialoug box bante  h

  void dialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Parshant App",
                    style: AppTextStyles.fontSize25(color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Are you sure you want to logout?",
                    style: AppTextStyles.fontSize18(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            //
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(130, 40)),
                          child: Text("No",
                              style: AppTextStyles.fontSize18(
                                  color: Colors.black))),
                      OutlinedButton(
                          onPressed: () async {
                            // yes clear data
                            await DatabaseHelper.instance.clearTableData2();
                            // 2nd okay
                            await SharedPreferencesHelper.clearValue(context);

                            // and now go to  log in page okay done
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LogInScreen()) , (route) => false);
                          },
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              minimumSize: const Size(130, 40)),
                          child: Text("Yes",
                              style: AppTextStyles.fontSize18(
                                  color: Colors.white))),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

