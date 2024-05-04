import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';
import 'package:wework_movies_app/core/app_constants/app_colors.dart';
import 'package:wework_movies_app/core/widgets/we_work_logo.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Column(
            children: [
              WeWorkLogo(
                  bgColor: Colors.black,
                  textColor: Colors.white,
                  textWidth: 24),
              Gap(4),
              Text('We Movies'),
            ],
          ),
          Column(
            children: [
              const Gap(2),
              Image.asset(AppAssets.mapFold, height: 24),
              const Gap(8),
              const Text('Explore'),
            ],
          ),
          Column(
            children: [
              Image.asset(
                AppAssets.calendarIcon,
                height: 30,
                color: AppColors.blue.shade800,
              ),
              const Gap(4),
              const Text('Upcoming'),
            ],
          ),
        ],
      ),
    );
  }
}
