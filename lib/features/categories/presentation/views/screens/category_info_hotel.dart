import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/categories/data/datasources/hotel_categories_datasources.dart';
import 'package:hotel_app/features/profile/presentation/extension/space_extension.dart';
import 'package:hotel_app/features/search/data/models/hotel_model.dart';
import 'package:hotel_app/features/categories/data/models/review_model.dart';
import 'package:hotel_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:hotel_app/features/booking/presentation/views/screens/booking_screen.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/carousel_slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryInfoHotel extends StatefulWidget {
  final HotelModel hotel;

  const CategoryInfoHotel({super.key, required this.hotel});

  @override
  State<CategoryInfoHotel> createState() => _CategoryInfoHotelState();
}

class _CategoryInfoHotelState extends State<CategoryInfoHotel> {
  final HotelRemoteDatasource controller = HotelRemoteDatasource();
  final TextEditingController commentController = TextEditingController();
  final AuthViewmodel user = AuthViewmodel();

  Map<String, bool> reviewHotels = {};
  double chooseRating = 0;

  @override
  void initState() {
    super.initState();
    controller.fetchHotels().then((ctx) {
      setState(() {});
    });
    loadReviewStatus();
  }

  Future<void> markHotelAsReviewed(String hotelId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reviewed_$hotelId', true);
  }

  Future<void> loadReviewStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final reviewed = prefs.getBool('reviewed_${widget.hotel.id}') ?? false;

    setState(() {
      reviewHotels[widget.hotel.id!] = reviewed;
    });
  }

  double calculateAverageRating(List<ReviewModel> reviews) {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<double>(0, (sum, r) => sum + r.rating);
    return total / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;
    final hasReviewed = reviewHotels[hotel.id] ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {});
            Navigator.pop(context, hotel);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "hotel".tr(context: context),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            25.h,
            CarouselSliderWidget(imageList: hotel.image),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF4F3F3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        hotel.description,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      8.h,
                      Text(
                        '${"price".tr(context: context)}: \$${hotel.price}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        " ${'rating'.tr(context: context)}: ${hotel.rating.toStringAsFixed(1)} ⭐",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      8.h,
                      Wrap(
                        spacing: 8,
                        children:
                            hotel.type
                                .map((t) => Chip(label: Text(t)))
                                .toList(),
                      ),
                      8.h,
                      Wrap(
                        spacing: 8,
                        children:
                            hotel.facilities
                                .map(
                                  (inx) => Chip(
                                    backgroundColor: Colors.blue,
                                    label: Text(inx),
                                  ),
                                )
                                .toList(),
                      ),
                      12.h,
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_1280,q_80/lsci/db/PICTURES/CMS/126700/126753.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      12.h,
                      Text(
                        'comments'.tr(context: context),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children:
                            hotel.reviews.map((review) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(review.comment),
                                subtitle: Row(
                                  children: List.generate(5, (i) {
                                    final starValue = i + 1;
                                    return Icon(
                                      review.rating >= starValue
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 18,
                                    );
                                  }),
                                ),
                              );
                            }).toList(),
                      ),
                      Divider(),
                      if (!hasReviewed) ...[
                        Text(
                          "write_comment".tr(context: context),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: "write_opinion".tr(context: context),
                          ),
                        ),
                        8.h,
                        Row(
                          children: List.generate(5, (index) {
                            final value = index + 1;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  chooseRating = value.toDouble();
                                });
                              },
                              child: Icon(
                                chooseRating >= value
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                              ),
                            );
                          }),
                        ),
                        8.h,
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (commentController.text.isNotEmpty &&
                                chooseRating > 0) {
                              final newComment = commentController.text;

                              await controller.addReview(
                                hotel.id!,
                                newComment,
                                chooseRating,
                              );

                              await markHotelAsReviewed(hotel.id!);

                              setState(() {
                                hotel.reviews.add(
                                  ReviewModel(
                                    comment: newComment,
                                    rating: chooseRating,
                                  ),
                                );

                                hotel.rating = calculateAverageRating(
                                  hotel.reviews,
                                );

                                reviewHotels[hotel.id!] = true;
                                commentController.clear();
                                chooseRating = 0;
                              });
                            }
                          },
                          child: Text(
                            "send_comment".tr(context: context),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        80.h,
                      ] else ...[
                        Text(
                          "already_reviewed".tr(context: context),
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        80.h,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Color(0xFF2D40EE), width: 2),
        ),
        height: 60,
        width: 300,
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (ctx) => BookingScreen(
                      id: user.userAuthModel?.id ?? "",
                      name: hotel.name,
                      images: hotel.image,
                      facilities: hotel.facilities,
                    ),
              ),
            );
          },
          child: Text(
            'booking'.tr(context: context),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 3,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
