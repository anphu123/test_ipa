import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

Future<void> showImageViewerDialog(
    BuildContext context,
    List<String> images,
    int initialIndex,
    ) async {
  final pageCtrl = PageController(initialPage: initialIndex);

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Image viewer',
    barrierColor: Colors.black87,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, __, child) {
      final curved = Curves.easeOutCubic.transform(anim.value);
      return Opacity(
        opacity: anim.value,
        child: Transform.scale(
          scale: 0.98 + 0.02 * curved,
          child: Dialog(
            backgroundColor: Colors.black,
            insetPadding: EdgeInsets.zero,
            child: Stack(
              children: [
                PhotoViewGallery.builder(
                  pageController: pageCtrl,
                  backgroundDecoration: const BoxDecoration(color: Colors.black),
                  itemCount: images.length,
                  builder: (ctx, i) => PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(images[i]),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 3.0,
                    heroAttributes: PhotoViewHeroAttributes(tag: 'pd-img-$i'),
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.white70, size: 40),
                    ),
                  ),
                ),

                // Close button
                Positioned(
                  top: MediaQuery.of(ctx).padding.top + 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ),

                // Index badge (sync with current page)
                Positioned(
                  bottom: MediaQuery.of(ctx).padding.bottom + 16,
                  right: 16,
                  child: AnimatedBuilder(
                    animation: pageCtrl,
                    builder: (_, __) {
                      final page = pageCtrl.hasClients && pageCtrl.page != null
                          ? pageCtrl.page!.round()
                          : initialIndex;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Text(
                          '${page + 1}/${images.length}',
                          style: AppTypography.s12.medium.withColor(Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}