import 'package:awesome_app/utils/constants.dart';
import 'package:awesome_app/utils/style/my_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/models/movie.dart';

class ItemGridMovie extends StatelessWidget {
  const ItemGridMovie({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: CachedNetworkImage(
              imageUrl: '$baseImageUrl${movie.posterPath}',
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
