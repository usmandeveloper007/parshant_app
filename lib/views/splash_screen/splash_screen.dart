import 'package:flutter/material.dart';
import 'package:parshant_app/core/utils/device_height_width.dart';
import 'package:parshant_app/providers/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SplashProvider>(context, listen: false)
          .navigateToNextScreen(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenDimensions.update(context);
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
