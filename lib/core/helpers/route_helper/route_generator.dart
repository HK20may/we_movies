import 'package:flutter/material.dart';
import 'package:wework_movies_app/core/helpers/route_helper/animated_route_builder.dart';
import 'package:wework_movies_app/core/helpers/route_helper/route_arguments.dart';
import 'package:wework_movies_app/core/helpers/route_helper/routes.dart';
import 'package:wework_movies_app/features/home/presentation/screens/home_screen.dart';

/// STEPS TO ADD A NEW SCREEN IN OUR CUSTOM [RouteGenerator]
///
///
/// {1} GO TO [Routes] AND ADD ROUTE NAME FOR EXAMPLE HOME = '/home';
/// {2} ADD YOUR SCREEN IN THE SWITCH CASES OF [routeName]
/// {3} [screenArguments] WILL TAKE ONLY ONE OBJECT (like [int],[String],[userDefinedClass])
///  [a]IN CASE YOUR SCREEN DON'T NEED ANY ARGUMENTS SKIP THE STEP
///  [b]IN CASE OF YOU WANT TO PASS DATA IN THE SCREEN
///   DEFINE A CLASS FOR EXAMPLE,
///    USER PAGE SCREEN NEED NAME AND EMAIL TO BE PASSED IN SCREEN
///    SO DEFINE UserPageRouteArgs: add name and Emails fields
///    YOUR SCREEN WILL TAKE ONE ARGUMENT THAT IS UserPageRouteArgs
///    WHICH CAN BE ACCESSED AS [screenArguments] below.
/// {4} NOW THE ROUTES ARE DEFINED USE THEM CALLING
// /    RouteHelper.push(Routes.name, args :[userDefinedArgs]) anywhere in Repo

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? routeName = settings.name;
    final RouteArguments? screenArguments =
        settings.arguments as RouteArguments?;
    final animationType = screenArguments?.animation;

    ///Here All screens will be defined for routing.
    final Widget widget;
    switch (routeName) {
      case Routes.HOME:
        widget = const HomeScreen();
        break;

      default:
        widget = const SizedBox();
        break;
    }

    switch (animationType) {
      case RouteAnimationType.slideLeft:
        return SlideLeftRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );

      case RouteAnimationType.slideRight:
        return SlideRightRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      case RouteAnimationType.slideTop:
        return SlideTopRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );

      case RouteAnimationType.slideBottom:
        return SlideBottomRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );

      case RouteAnimationType.zoomOut:
        return ZoomOutRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      case RouteAnimationType.zoomOutAndFade:
        return ZoomOutAndFadeRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );

      case RouteAnimationType.fade:
        return FadeRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => widget,
          settings: RouteSettings(name: routeName),
        );
    }
  }
}
