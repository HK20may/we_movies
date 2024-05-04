import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';

class AppErrorWidget extends StatefulWidget {
  final VoidCallback? onTap;
  const AppErrorWidget({super.key, required this.onTap});

  @override
  State<AppErrorWidget> createState() => _AppErrorWidgetState();
}

class _AppErrorWidgetState extends State<AppErrorWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationControllerGif;

  @override
  void initState() {
    _animationControllerGif = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loadLottie(),
          ElevatedButton(
              style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(2),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade500)),
              onPressed: widget.onTap,
              child: const Text(
                "Try Again",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  Widget loadLottie() {
    return Lottie.asset(
      AppAssets.errorLottie,
      controller: _animationControllerGif,
      width: MediaQuery.of(context).size.width,

      // animate: true,
      repeat: true,
      onLoaded: ((composition) {
        _animationControllerGif
          ..duration = composition.duration
          ..repeat();
        // ..forward();
      }),
    );
  }
}
