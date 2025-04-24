import 'package:hotel_app/features/booking/data/datasources/remote_booking_datasources.dart';

import '../../data/models/booking_model.dart';

class BookingViewModel {
  //
  BookingViewModel._konstruktor();
  static final BookingViewModel object = BookingViewModel._konstruktor();
  factory BookingViewModel() {
    return object;
  }
  //

  final remoteData = RemoteBookingDatasources();
  List<BookingModel> bookings = [];
  Future<bool> makeBooking({
    required String userId,
    required BookingModel booking,
  }) async {
    try {
      return await RemoteBookingDatasources.createBooking(booking, userId);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> getBookings(String userId) async {
    bookings = await RemoteBookingDatasources.getBookings(userId);
  }
}
