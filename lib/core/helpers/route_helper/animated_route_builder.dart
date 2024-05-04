import 'package:flutter/material.dart';

/// This Page route [SlideLeftRouteBuilder] will animate from Left to Right
class SlideLeftRouteBuilder extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? routeSettings;
  SlideLeftRouteBuilder({required this.widget, this.routeSettings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          settings: routeSettings,
        );
}

/// This Page route [SlideRightRouteBuilder] will animate from to Right to Left

class SlideRightRouteBuilder extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? routeSettings;
  SlideRightRouteBuilder({required this.widget, this.routeSettings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          settings: routeSettings,
        );
}

/// This Page route [SlideTopRouteBuilder] will animate from Top to Bottom

class SlideTopRouteBuilder extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? routeSettings;
  SlideTopRouteBuilder({required this.widget, this.routeSettings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          settings: routeSettings,
        );
}

/// This Page route [SlideBottomRouteBuilder] will animate from Bottom to Top

class SlideBottomRouteBuilder extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? routeSettings;
  SlideBottomRouteBuilder({required this.widget, this.routeSettings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          settings: routeSettings,
        );
}

/// This Page route [ZoomOutRouteBuilder] will Zoom the new screen from 0 to 1

class ZoomOutRouteBuilder extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? routeSettings;
  ZoomOutRouteBuilder({required this.widget, this.routeSettings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
          settings: routeSettings,
        );
}

/// This Page route [FadeRouteBuilder] will Fade the new screen from 0 to 1

class FadeRouteBuilder extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? routeSettings;
  FadeRouteBuilder({required this.widget, this.routeSettings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          settings: routeSettings,
        );
}

/// This Page route [ZoomOutAndFadeRouteBuilder] will Fade the new screen
/// from 0 to 1 with zooming from 0 to 1 simultaneously

class ZoomOutAndFadeRouteBuilder extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? routeSettings;
  ZoomOutAndFadeRouteBuilder({required this.widget, this.routeSettings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          settings: routeSettings,
        );
}
