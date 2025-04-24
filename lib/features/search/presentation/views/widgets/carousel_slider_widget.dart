import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({super.key, required this.imageList});
  final List imageList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 3),
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        // autoPlayInterval: Duration(seconds: 5),
        autoPlayCurve: Curves.fastOutSlowIn,
        // aspectRatio: 2,
      ),
      items:
          imageList.map((url) {
            return Builder(
              builder:
                  (context) => ClipRRect(
                    child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
                  ),
            );
          }).toList(),
    );
  }
}
