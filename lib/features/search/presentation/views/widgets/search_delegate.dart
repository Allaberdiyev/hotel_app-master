import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/router/routes.dart';
import 'package:hotel_app/features/search/data/models/hotel_model.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/filter_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/search_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/carousel_slider_widget.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/rating_widget.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/text_item.dart';
import 'package:provider/provider.dart';

class SearchViewDelegate extends SearchDelegate<HotelModel> {
  SearchViewDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.filter);
        },
        icon: Icon(Icons.filter_list, color: Colors.black),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        close(
          context,
          HotelModel(
            name: '',
            address: '',
            description: '',
            facilities: [],
            image: [],
            price: 0,
            rating: 0,
            type: [],
            id: '',
            reviews: [],
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final search = context.watch<SearchViewmodel>();
    final filter = context.read<FilterViewmodel>();

    var hotels = search.hotels;
    final suggestionList =
        hotels.where((hotel) {
          final facilitiesLower =
              hotel.facilities.map((e) => e.toLowerCase()).toList();

          final name = hotel.name.toLowerCase().contains(query.toLowerCase());
          final rating = hotel.rating >= filter.selectRating.toInt();

          final address = hotel.address.toLowerCase().contains(
            query.toLowerCase(),
          );

          bool facilitiesMatch = true;

          if (filter.wf) {
            facilitiesMatch = facilitiesMatch && facilitiesLower.contains("wf");
          }
          if (filter.tv) {
            facilitiesMatch = facilitiesMatch && facilitiesLower.contains("tv");
          }
          if (filter.basseyn) {
            facilitiesMatch =
                facilitiesMatch &&
                facilitiesLower.contains("basseyn".tr(context: context));
          }
          if (filter.breakfast) {
            facilitiesMatch =
                facilitiesMatch &&
                facilitiesLower.contains("breakfast".tr(context: context));
          }

          bool priceMatch = true;

          final minPrice = filter.minController.text;
          final maxPrice = filter.maxController.text;

          if (minPrice.isNotEmpty || maxPrice.isEmpty) {
            final min = minPrice.isNotEmpty ? int.parse(minPrice) : 0;
            final max =
                maxPrice.isNotEmpty ? int.parse(maxPrice) : double.infinity;
            priceMatch = hotel.price >= min && hotel.price <= max;
          }

          return (query.isEmpty || name || address) &&
              facilitiesMatch &&
              rating &&
              priceMatch;
        }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final hotel = suggestionList[index];
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black.withValues(alpha: 0.2),
                    offset: Offset(2, 4),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CarouselSliderWidget(imageList: hotel.image),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextItem(
                            text: hotel.name,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          TextItem(
                            text: hotel.address,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: RatingWidget(rating: hotel.rating.toInt()),
              ),
            ),
          ],
        );
      },
    );
  }
}
