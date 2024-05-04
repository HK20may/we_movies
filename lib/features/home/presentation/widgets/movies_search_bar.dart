import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wework_movies_app/core/app_constants/app_assets.dart';
import 'package:wework_movies_app/features/home/cubit/home_cubit.dart';

class MoviesSearchBar extends StatelessWidget {
  const MoviesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search Movies by name...',
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            isDense: true,
            hintStyle: const TextStyle(fontWeight: FontWeight.w400),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(AppAssets.searchIcon, height: 22),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide.none),
            fillColor: Colors.white,
            filled: true,
          ),
          onChanged: (value) {
            cubit.filterMovies(value);
          },
        ),
      ),
    );
  }
}
