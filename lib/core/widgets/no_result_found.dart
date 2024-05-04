import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';

class NoResultFound extends StatelessWidget {
  const NoResultFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(48),
        Image.asset(AppAssets.noResultFound),
        const Text(
          "No Results Found",
          style: TextStyle(
              fontSize: 24, color: Colors.red, fontWeight: FontWeight.w500),
        ),
        Gap(MediaQuery.of(context).size.width)
      ],
    );
  }
}
