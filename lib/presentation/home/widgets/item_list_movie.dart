import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/models/movie.dart';
import '../../../utils/constants.dart';
import '../../../utils/style/my_text_style.dart';

class ItemListMovie extends StatelessWidget {
  const ItemListMovie({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(8.0)),
            child: CachedNetworkImage(
              imageUrl: '$baseImageUrl${movie.backdropPath}',
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  movie.originalTitle ?? '',
                  style: MyTextStyle.title,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: MyTextStyle.body,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
