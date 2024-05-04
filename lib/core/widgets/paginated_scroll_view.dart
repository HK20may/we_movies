import 'package:flutter/material.dart';

class PaginatedScrollView extends StatefulWidget {
  final Axis scrollDirection;
  final List<Widget> sliversList;
  final VoidCallback? onReachedEnd;
  const PaginatedScrollView(
      {super.key,
      this.scrollDirection = Axis.vertical,
      required this.sliversList,
      this.onReachedEnd});

  @override
  State<PaginatedScrollView> createState() => _PaginatedScrollViewState();
}

class _PaginatedScrollViewState extends State<PaginatedScrollView> {
  final ScrollController _scrollController = ScrollController();
  late VoidCallback _loadMoreListener;

  @override
  void initState() {
    super.initState();
    _loadMoreListener = () {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 400) {
        widget.onReachedEnd?.call();
      }
    };
    _scrollController.addListener(_loadMoreListener);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: widget.sliversList,
      scrollDirection: widget.scrollDirection,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
