import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemGridLoading extends StatelessWidget {
  const ItemGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white10,
      child: const Card(),
    );
  }
}
