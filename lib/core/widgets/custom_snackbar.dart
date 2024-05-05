import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';
import 'package:wework_movies_app/core/app_constants/app_colors.dart';

class CustomSnackbar {
  static show({
    required BuildContext context,
    required String msg,
    SnackBarBehavior? snackBehavior = SnackBarBehavior.fixed,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.all(8),
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 4),
            child: SvgPicture.asset(
              AppAssets.alertRed,
              width: 24,
            ),
          ),
          Expanded(
            child: Text(msg,
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.red,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      duration: const Duration(days: 365),
      backgroundColor: AppColors.red.shade100,
    ));
  }
}
