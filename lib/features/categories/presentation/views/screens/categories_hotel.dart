import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/categories/data/datasources/hotel_categories_datasources.dart';
import 'package:hotel_app/features/profile/presentation/views/widgets/drawer_widget.dart';
import 'package:hotel_app/features/search/data/models/hotel_model.dart';
import 'package:hotel_app/features/categories/presentation/views/screens/category_info_hotel.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/carousel_slider_widget.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/search_delegate.dart';

class CategoriesHotel extends StatefulWidget {
  const CategoriesHotel({super.key});

  @override
  State<CategoriesHotel> createState() => _CategoriesHotelState();
}

class _CategoriesHotelState extends State<CategoriesHotel> {
  final HotelRemoteDatasource controller = HotelRemoteDatasource();

  List<HotelModel> hotels = [];
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadHotels();
  }

  Future<void> loadHotels() async {
    await controller.fetchHotels();
    setState(() {
      hotels = controller.getAllHotels();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 20),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'hotels'.tr(context: context),
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchViewDelegate());
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final updatedHotel = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => CategoryInfoHotel(hotel: hotel),
                          ),
                        );
                        if (updatedHotel != null) {
                          setState(() {
                            hotels[index] = updatedHotel;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: isDark ? Colors.black : Colors.white,

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(70),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSliderWidget(imageList: hotel.image),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotel.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    hotel.address,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${'rating'.tr(context: context)}: ${hotel.rating.toStringAsFixed(1)} ⭐',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment(1, 1),
                                    child: Text(
                                      '\$${hotel.price}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
