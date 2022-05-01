import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.url,
    required this.radius,
  }) : super(key: key);

  const Avatar.small({
    Key? key,
    required this.url,
  })  : radius = 16,
        super(key: key);

  const Avatar.medium({
    Key? key,
    required this.url,
  })  : radius = 22,
        super(key: key);

  const Avatar.large({
    Key? key,
    required this.url,
  })  : radius = 30,
        super(key: key);

  final double radius;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: CachedNetworkImageProvider(url),
          backgroundColor: Theme.of(context).cardColor,
        ),
        Positioned(
          bottom: 0.0,
          right: 6.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            height: 11,
            width: 11,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 10,
                width: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
