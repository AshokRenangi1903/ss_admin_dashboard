import 'package:flutter/material.dart';

class ImageBannerCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;

  const ImageBannerCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Responsive image width
        final imageWidth = width * 0.48;

        return Container(
          height: 230,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                spreadRadius: 1,
                offset: const Offset(0, 8),
                color: Colors.black.withValues(alpha: 0.12),
              ),
            ],
          ),
          child: Stack(
            children: [
              // --------------------------------------------------
              // IMAGE
              // --------------------------------------------------
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: imageWidth,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: bgColor,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.white54,
                          size: 42,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // --------------------------------------------------
              // DARK OVERLAY ON IMAGE
              // --------------------------------------------------
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: imageWidth,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withValues(alpha: 0.05),
                        Colors.black.withValues(alpha: 0.12),
                        Colors.black.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),

              // --------------------------------------------------
              // MAIN FADE
              // --------------------------------------------------
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        bgColor.withValues(alpha: 0.35),
                        bgColor.withValues(alpha: 0.85),
                        bgColor,
                      ],
                      stops: const [0.00, 0.25, 0.42, 0.62, 0.78],
                    ),
                  ),
                ),
              ),

              // --------------------------------------------------
              // CONTENT
              // --------------------------------------------------
              Positioned(
                left: imageWidth * 0.75,
                right: 40,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                            letterSpacing: -0.4,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.78),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
