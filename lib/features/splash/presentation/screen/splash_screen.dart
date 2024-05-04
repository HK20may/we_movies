import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wework_movies_app/core/helpers/route_helper/route_helper.dart';
import 'package:wework_movies_app/core/helpers/route_helper/routes.dart';
import 'package:wework_movies_app/core/web_services/location_services.dart';
import 'package:wework_movies_app/core/widgets/toast_message.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    ToastMessage.init();
    _navigateToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinKitRing(
              color: Colors.black,
              lineWidth: 3,
              size: 140,
            ),
            Text(
              "wework",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToNextScreen() async {
    // Delay for 2 seconds
    // await Future.delayed(const Duration(seconds: 2));
    await LocationServices.fetchUserLocation();
    RouteHelper.pushReplacement(Routes.HOME);
  }
}
