import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPreviousPage,
    required this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: currentPage != 1  ? onPreviousPage : null,
        ),
        Text('$currentPage / $totalPages'),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: currentPage != totalPages  ? onNextPage : null,
        ),
      ],
    );
  }
}
