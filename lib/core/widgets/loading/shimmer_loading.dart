import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wework_movies_app/core/app_constants/app_colors.dart';
import 'package:wework_movies_app/core/widgets/loading/shimmer_layout.dart';

class ShimmerLoading extends StatelessWidget {
  final Widget? shimmerWidget;
  const ShimmerLoading({super.key, this.shimmerWidget});

  @override
  Widget build(BuildContext context) {
    int time = 800;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Shimmer.fromColors(
            highlightColor: AppColors.greyColor.withOpacity(0.4),
            baseColor: AppColors.blue.shade300,
            period: Duration(milliseconds: time),
            child: shimmerWidget ?? const ShimmerLayout(),
          ),
        ),
      ),
    );
  }
}
