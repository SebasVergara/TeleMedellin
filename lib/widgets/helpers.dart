import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;

  CachedImage(this.url, {this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url.isNotEmpty ? url : '',
      fit: BoxFit.cover,
      placeholder: (_, __) => Image.asset(
        'images/placeholder.jpg',
        width: width,
        height: height,
      ),
      errorWidget: (context, url, error) => Image.asset(
        'images/placeholder.jpg',
        width: width,
        height: height,
      ),
    );
  }
}
