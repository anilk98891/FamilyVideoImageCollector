import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

Widget customImageView(BuildContext context,String url) {
return Container(
    child: CachedNetworkImage(
      imageUrl: url,
      imageBuilder:
          (context, imageProvider) =>
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover),
            ),
          ),
      placeholder: (context, url) =>
          CircularProgressIndicator(),
      errorWidget: (context, url, error)
      => Icon(Icons.error),
    ),
);
}