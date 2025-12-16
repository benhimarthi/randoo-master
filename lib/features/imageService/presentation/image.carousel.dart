import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'fullscreen_image_page.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final double height;
  final bool autoPlay;
  final Widget? emptyPlaceholder;

  const ImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 200,
    this.autoPlay = true,
    this.emptyPlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child:
              emptyPlaceholder ??
              const Text(
                "No images available",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
        ),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        autoPlay: autoPlay,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
      items: imageUrls.map((url) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullscreenImagePage(imageUrl: url),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.broken_image, size: 40)),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
