import 'package:flutter/material.dart';
import 'package:parshant_app/views/auth/log_in_screen.dart';
import 'package:parshant_app/views/auth/register_screen.dart';
import 'package:parshant_app/views/splash_screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(const SplashScreen());
      case '/login':
        return _buildRoute(const LogInScreen());
      case '/register':
        return _buildRoute(const RegisterScreen());
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static MaterialPageRoute _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('ERROR')),
      ),
    );
  }
}
