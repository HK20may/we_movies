import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';
import 'package:wework_movies_app/core/web_services/location_services.dart';
import 'package:wework_movies_app/core/widgets/we_work_logo.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppAssets.locationPin,
                      height: 16,
                    ),
                    Flexible(
                      child: Text(
                        LocationServices.mainAddress,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Text(
                    LocationServices.secondaryAddress,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black45,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(32),
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: WeWorkLogo(
              bgColor: Colors.white,
              textColor: Colors.black,
              textWidth: 40,
            ),
          ),
        ],
      ),
    );
  }
}
