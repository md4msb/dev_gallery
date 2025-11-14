import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarPhoto extends StatelessWidget {
  final double? radius;
  final String url;
  final String username;
  const AvatarPhoto({
    super.key,
    this.radius,
    required this.url,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: url.isNotEmpty ? CachedNetworkImageProvider(url) : null,
      child: url.isEmpty
          ? Text(
              username[0].toUpperCase(),
              style: const TextStyle(fontSize: 24),
            )
          : null,
    );
  }
}
