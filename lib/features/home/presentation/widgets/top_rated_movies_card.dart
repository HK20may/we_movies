import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';
import 'package:wework_movies_app/core/app_constants/app_colors.dart';
import 'package:wework_movies_app/core/app_constants/string_constants.dart';
import 'package:wework_movies_app/core/utils/we_movies_utils.dart';
import 'package:wework_movies_app/features/home/cubit/home_cubit.dart';
import 'package:wework_movies_app/features/home/data/models/results.dart';

class TopRatedMoviesCard extends StatelessWidget {
  final int index;
  const TopRatedMoviesCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();
    Results movieData = cubit.isSearching
        ? cubit.searchedTopRatedMoviesList[index]
        : cubit.topRatedMoviesList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 20, left: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: AppColors.boxShadowColor.withOpacity(.6),
              offset: const Offset(0, 0),
              blurRadius: 16,
              spreadRadius: -5),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                      imageUrl: movieData.backdropPath ?? AppAssets.placeHolder,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black26,
                                  AppColors.secondaryBlackColor
                                      .withOpacity(0.1),
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft),
                          ),
                        );
                      }),
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.all(
                        (movieData.popularity?.toInt().toString().length ?? 0) >
                                2
                            ? 10
                            : 16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade800),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppAssets.eyeIcon,
                          color: AppColors.blue.shade200,
                          height: 22,
                        ),
                        Text(
                          "${movieData.popularity?.toInt().toString()}K",
                          style: TextStyle(
                              color: AppColors.blue.shade400,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              movieData.originalTitle ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.calendarIcon,
                  height: 20,
                  color: AppColors.blue.shade700,
                ),
                const Gap(4),
                Flexible(
                  child: Text(
                    movieData.overview ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: AppColors.blue.shade700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(4),
                  Text(
                    "${WeMoviesUtils().formatNumber(movieData.voteCount ?? 0)} ${StringConstants.votes}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: VerticalDivider(
                      thickness: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    movieData.voteAverage.toString(),
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const Gap(4),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "⭐",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(24)
        ],
      ),
    );
  }
}
