import 'package:flutter/material.dart';
import 'package:wework_movies_app/core/helpers/route_helper/route_arguments.dart';

mixin RouteHelper {
  /// Defined as [navigatorKey] inside [MaterialApp]
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get navigatorContext => navigatorKey.currentContext!;

  static Future<Object?> push(
    String routeName, {
    Object? args,
    RouteAnimationType? animation,
    BuildContext? context,
  }) {
    return Navigator.of(context ?? navigatorContext).pushNamed(routeName,
        arguments: RouteArguments(
          args,
          animation: animation,
        ));
  }

  static Future<Object?> pushScreen(Widget widget, {BuildContext? context}) {
    return Navigator.of(context ?? navigatorContext).push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static Future<Object?> pushReplacement(
    String routeName, {
    Object? args,
    RouteAnimationType? animation,
    BuildContext? context,
  }) {
    return Navigator.of(context ?? navigatorContext).pushReplacementNamed(
      routeName,
      arguments: RouteArguments(
        args,
        animation: animation,
      ),
    );
  }

  static Future<Object?> pushAndPopUntil(
    String routeName, {
    String? popUntilRouteName,
    Object? args,
    RouteAnimationType? animation,
    BuildContext? context,
  }) {
    return Navigator.of(context ?? navigatorContext).pushNamedAndRemoveUntil(
      routeName,
      popUntilRouteName != null
          ? ModalRoute.withName(popUntilRouteName)
          : (Route<dynamic> route) => false,
      arguments: RouteArguments(args, animation: animation),
    );
  }

  static void pop({dynamic args}) {
    return Navigator.of(navigatorContext).pop(args);
  }

  static bool canPop() {
    return Navigator.of(navigatorContext).canPop();
  }

  static Future<bool> maybePop() {
    return Navigator.of(navigatorContext).maybePop();
  }

  static void popUntil(String routesName) {
    Navigator.of(navigatorContext).popUntil(ModalRoute.withName(routesName));
  }

  static void popUntilCount({required int count}) {
    int n = 0;
    Navigator.of(navigatorContext).popUntil((_) => n++ >= count);
  }
}
