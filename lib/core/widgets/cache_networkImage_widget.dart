import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'loading_shimmer.widget.dart';

class CacheNetworkImage extends StatelessWidget {
  const CacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isCircular = false,
    this.borderRadius,
    this.placeholderImage,
    this.memCacheWidth,
    this.memCacheHeight,
    this.fadeInDuration = const Duration(milliseconds: 250),
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isCircular;
  final BorderRadius? borderRadius;
  final String? placeholderImage;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Duration fadeInDuration;

  @override
  Widget build(BuildContext context) {
    final cleanUrl = imageUrl?.trim();
    if (cleanUrl == null || cleanUrl.isEmpty) {
      return _buildError();
    }

    final dpr = MediaQuery.devicePixelRatioOf(context);

    final int? computedCacheWidth = memCacheWidth ?? _safeMemCache(width, dpr);
    final int? computedCacheHeight =
        memCacheHeight ?? _safeMemCache(height, dpr);

    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: cleanUrl,
        fit: fit,
        memCacheWidth: computedCacheWidth,
        memCacheHeight: computedCacheHeight,
        fadeInDuration: fadeInDuration,
        fadeOutDuration: const Duration(milliseconds: 150),
        useOldImageOnUrlChange: true,
        placeholder: (_, _) => const _ImagePlaceholderKeyed(),
        errorWidget: (_, _, _) => const _ImageErrorKeyed(),
        imageBuilder: (context, imageProvider) {
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircular ? null : borderRadius,
              image: DecorationImage(image: imageProvider, fit: fit),
            ),
          );
        },
      ),
    );
  }

  static int? _safeMemCache(double? size, double dpr) {
    if (size == null || size.isInfinite || size.isNaN || size <= 0) return null;
    final cachedSize = (size * dpr).round();
    return cachedSize > 1200 ? 1200 : cachedSize;
  }

  Widget _buildPlaceholder() {
    if (placeholderImage != null) {
      return Image.asset(
        placeholderImage!,
        fit: fit,
        width: width,
        height: height,
      );
    }
    return LoadingShimmer(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      isCircular: isCircular,
      borderRadius: borderRadius,
    );
  }

  Widget _buildError() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: isCircular ? null : borderRadius,
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: const Icon(Icons.error_outline, color: Colors.grey, size: 30),
    );
  }
}

class _ImagePlaceholderKeyed extends StatelessWidget {
  const _ImagePlaceholderKeyed();

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<CacheNetworkImage>();
    return parent?._buildPlaceholder() ?? const SizedBox.shrink();
  }
}

class _ImageErrorKeyed extends StatelessWidget {
  const _ImageErrorKeyed();

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<CacheNetworkImage>();
    return parent?._buildError() ?? const SizedBox.shrink();
  }
}
