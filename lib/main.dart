import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parshant_app/providers/jodi_game_provider.dart';
import 'package:parshant_app/providers/splash_provider.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_generators.dart';
import 'providers/balance_provider.dart';

Future<void> _initializeApp() async {
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(
      const MyApp()

  //     DevicePreview(
  //   builder: (context) {
  //     return const MyApp();
  //   }
  // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => BalanceProvider()),
        ChangeNotifierProvider(create: (context) => JodiGameChangeNotifier()),
      ],
      child: const ScreenUtilInit(
        designSize: Size(448, 978),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          initialRoute: AppRouter.home,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Parshant App',
        ),
      ),
    );
  }
}
