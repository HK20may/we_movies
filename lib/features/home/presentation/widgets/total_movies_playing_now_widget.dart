import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wework_movies_app/core/app_constants/app_colors.dart';
import 'package:wework_movies_app/core/app_constants/string_constants.dart';
import 'package:wework_movies_app/core/utils/we_movies_utils.dart';
import 'package:wework_movies_app/core/widgets/custom_container.dart';
import 'package:wework_movies_app/features/home/cubit/home_cubit.dart';

class TotalMoviesPlayingNowWidget extends StatelessWidget {
  const TotalMoviesPlayingNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Positioned(top: 24, child: _todaysDate()),
          CustomContainer(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black26,
                    AppColors.secondaryBlackColor.withOpacity(0.1),
                  ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                  borderRadius: const BorderRadius.all(Radius.circular(24))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(40),
                    const Text(
                      StringConstants.weMovies,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Gap(6),
                    Text(
                      "${cubit.nowPlayingMoviesList.length} ${StringConstants.moviesAreLoadedInNowPlaying}",
                      style: TextStyle(
                          color: AppColors.blue.shade900,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _todaysDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        WeMoviesUtils().formatTodayDate(DateTime.now()),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
