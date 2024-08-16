import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transparent_image/transparent_image.dart';

import '../const/colors.dart';

class FullScreenGallery extends StatelessWidget {
  final String imageUrl;
  final int initialIndex;

  const FullScreenGallery({
    super.key,
    required this.imageUrl,
    required this.initialIndex,
  });

  Widget _buildImageWidget(String? imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
      placeholder: (context, url) => Image.memory(kTransparentImage),
      errorWidget: (context, url, error) => Container(
        color: gray100,
        child: Center(
          child: Icon(
            Icons.warning,
            size: 80.w,
          ),
        ),
      ),
      fadeInDuration: const Duration(milliseconds: 100),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 0.w,
          ),
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      body: InteractiveViewer(
        maxScale: 4,
        child: _buildImageWidget(imageUrl),
      ),
    );
  }
}
