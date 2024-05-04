import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';
import 'package:wework_movies_app/core/app_constants/app_colors.dart';
import 'package:wework_movies_app/core/helpers/route_helper/route_helper.dart';

class ToastMessage {
  static final FToast fToast = FToast();
  static void init() {
    fToast.init(RouteHelper.navigatorContext);
  }

  static void error({required String msg}) {
    showToast(
        msg: msg,
        bgColor: AppColors.red.shade100,
        msgColor: AppColors.red.shade600,
        showIcon: true);
  }

  static void info({required String msg}) {
    showToast(msg: msg);
  }

  static void showToast(
      {String msg = "",
      Color bgColor = Colors.black87,
      Color msgColor = Colors.white,
      showIcon = false}) {
    final toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon)
              Padding(
                  padding: const EdgeInsets.only(right: 10, top: 4),
                  child: SvgPicture.asset(
                    AppAssets.alertRed,
                    width: 24,
                  )),
            Text(msg,
                style: TextStyle(
                    fontSize: 14,
                    color: msgColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
  }
}
