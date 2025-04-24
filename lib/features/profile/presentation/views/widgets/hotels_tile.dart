import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/profile/presentation/views/widgets/rich_text_widget.dart';

class HotelsTile extends StatelessWidget {
  final List<String> image;
  final String name;
  final int price;
  final String description;
  final String type;
  final List<String> facilities;
  const HotelsTile({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.type,
    required this.facilities,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDark ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.w800)),
              CarouselSlider(
                items:
                    image.map((url) {
                      return Builder(
                        builder: (context) {
                          return CachedNetworkImage(imageUrl: url);
                        },
                      );
                    }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.ease,
                ),
              ),
              RichTextWidget(
                subtitle: "price".tr(context: context),
                title: "$price",
              ),
              RichTextWidget(subtitle: "description", title: description),
              RichTextWidget(
                subtitle: "type".tr(context: context),
                title: type,
              ),
              RichTextWidget(
                subtitle: "facilities".tr(context: context),
                title: facilities.join(", "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
