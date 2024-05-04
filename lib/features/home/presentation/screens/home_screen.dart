// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wework_movies_app/core/app_constants/string_constants.dart';
import 'package:wework_movies_app/core/widgets/app_error_widget.dart';
import 'package:wework_movies_app/core/widgets/fading_line.dart';
import 'package:wework_movies_app/core/widgets/loading/shimmer_loading.dart';
import 'package:wework_movies_app/core/widgets/no_result_found.dart';
import 'package:wework_movies_app/features/home/cubit/home_cubit.dart';
import 'package:wework_movies_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:wework_movies_app/features/home/presentation/widgets/home_nav_bar.dart';
import 'package:wework_movies_app/features/home/presentation/widgets/movies_search_bar.dart';
import 'package:wework_movies_app/features/home/presentation/widgets/now_playing_movies_card.dart';
import 'package:wework_movies_app/features/home/presentation/widgets/top_rated_movies_card.dart';
import 'package:wework_movies_app/features/home/presentation/widgets/total_movies_playing_now_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchMoviesData(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();

        if (state is HomeLoading) {
          return const ShimmerLoading();
        }
        if (state is HomeError) {
          return AppErrorWidget(
            onTap: () async {
              await cubit.fetchMoviesData();
            },
          );
        }
        return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 142, 111, 145),
                    Colors.white,
                  ],
                ),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.fetchMoviesData();
                },
                child: NotificationListener<ScrollEndNotification>(
                  onNotification: (scrollEnd) {
                    if (cubit.isSearching) {
                      return false;
                    }
                    final metrics = scrollEnd.metrics;
                    double maxScroll = metrics.maxScrollExtent;
                    double currentScroll = metrics.pixels;
                    double delta = 400.0;
                    if (maxScroll - currentScroll <= delta) {
                      cubit.getPaginationTopRatedMovies();
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(kToolbarHeight),
                        const HomeAppBar(),
                        const Gap(24),
                        const MoviesSearchBar(),
                        if (cubit.isSearching && cubit.noResultFound) ...[
                          NoResultFound()
                        ] else ...[
                          if (!cubit.isSearching) ...[
                            const Gap(24),
                            TotalMoviesPlayingNowWidget(),
                            const Gap(32),
                          ],
                          if (cubit.isSearching &&
                              cubit
                                  .searchedNowPlayingMoviesList.isNotEmpty) ...[
                            const Gap(32),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "${cubit.searchedNowPlayingMoviesList.length} ${StringConstants.resultsFoundIn}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const Gap(2),
                          ],
                          ..._buildNowPlayingMoviesWidget(cubit),
                          if (!cubit.isSearching) const Gap(32),
                          if (cubit.isSearching &&
                              cubit.searchedTopRatedMoviesList.isNotEmpty) ...[
                            const Gap(32),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "${cubit.searchedTopRatedMoviesList.length} ${StringConstants.resultsFoundIn}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const Gap(2),
                          ],
                          ..._buildNowTopRatedWidget(cubit)
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const HomeNavBar());
      },
    );
  }

  List<Widget> _buildNowPlayingMoviesWidget(HomeCubit cubit) {
    if (cubit.isSearching && cubit.searchedNowPlayingMoviesList.isEmpty) {
      return [];
    }
    return [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              StringConstants.nowPlaying,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Gap(16),
            FadingLine(),
          ],
        ),
      ),
      const Gap(20),
      SizedBox(
        height: 350,
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            if (cubit.isSearching) {
              return false;
            }
            final metrics = scrollEnd.metrics;
            double maxScroll = metrics.maxScrollExtent;
            double currentScroll = metrics.pixels;
            double delta = 400.0;
            if (maxScroll - currentScroll <= delta) {
              cubit.getPaginationNowPlayingMovies();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: cubit.isSearching
                ? cubit.searchedNowPlayingMoviesList.length
                : cubit.nowPlayingMoviesList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return NowPlayingMoviesCard(index: index);
            },
          ),
        ),
      )
    ];
  }

  List<Widget> _buildNowTopRatedWidget(HomeCubit cubit) {
    if (cubit.isSearching && cubit.searchedTopRatedMoviesList.isEmpty) {
      return [];
    }
    return [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringConstants.topRated,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Gap(16),
            FadingLine(),
          ],
        ),
      ),
      ListView.builder(
        itemCount: cubit.isSearching
            ? cubit.searchedTopRatedMoviesList.length
            : cubit.topRatedMoviesList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return TopRatedMoviesCard(index: index);
        },
      )
    ];
  }
}
