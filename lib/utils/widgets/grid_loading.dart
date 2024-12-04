import 'package:awesome_app/utils/widgets/item_grid_loading.dart';
import 'package:flutter/cupertino.dart';

class GridLoading extends StatelessWidget {
  const GridLoading({super.key, this.isSimilar});

  final bool? isSimilar;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: isSimilar ?? false,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7),
      itemCount: 8,
      itemBuilder: (context, index) {
        return const ItemGridLoading();
      },
    );
  }
}
