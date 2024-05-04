import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wework_movies_app/core/helpers/route_helper/route_generator.dart';
import 'package:wework_movies_app/core/helpers/route_helper/route_helper.dart';
import 'package:wework_movies_app/features/splash/presentation/screen/splash_screen.dart';

class WeWorkApp extends StatelessWidget {
  const WeWorkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We-Work',
      navigatorKey: RouteHelper.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        fontFamily: "PlusJakartaSans",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) => FToastBuilder()(context, child),
      home: const SplashScreen(),
    );
  }
}
