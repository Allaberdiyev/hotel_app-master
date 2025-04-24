import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/bookings_model.dart';
import '../widgets/hotels_tile.dart';

class BookinsList extends StatelessWidget {
  final Map<String, BookingsModel> bookings;

  const BookinsList({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hotel_history".tr(context: context))),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings.values.elementAt(index);
          return HotelsTile(
            image: booking.images,
            name: booking.name,
            price: booking.totalPrice,
            description: booking.description,
            type: booking.type,
            facilities: booking.facilities,
          );
        },
      ),
    );
  }
}
