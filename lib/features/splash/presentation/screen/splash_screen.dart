import 'package:flutter/material.dart';
import 'package:wework_movies_app/core/app_constants/string_constants.dart';
import 'package:wework_movies_app/core/helpers/route_helper/route_helper.dart';
import 'package:wework_movies_app/core/helpers/route_helper/routes.dart';
import 'package:wework_movies_app/core/web_services/location_services.dart';
import 'package:wework_movies_app/core/widgets/custom_snackbar.dart';
import 'package:wework_movies_app/core/widgets/toast_message.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    _animationController.repeat();
    ToastMessage.init();
    _navigateToNextScreen();
  }

  @override
  void didChangeDependencies() {
    _navigateToNextScreen();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: 170,
        width: 170,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black54,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 170,
              width: 170,
              child: RotatedBox(
                quarterTurns: 1,
                child: CircularProgressIndicator(
                  value: _animationController.value,
                  strokeWidth: 4,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(
              StringConstants.weWork,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _navigateToNextScreen() async {
    bool locPermission = await LocationServices.fetchUserLocation();
    if (locPermission) {
      // Delay for 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      RouteHelper.pushReplacement(Routes.HOME);
    } else {
      CustomSnackbar.show(
        // ignore: use_build_context_synchronously
        context: context,
        msg: StringConstants.locationPermissionNeeded,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
