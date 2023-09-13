import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/models/hotels_model.dart';
import 'package:hotel_reservation_app/resources/dialog_setup.dart';
import 'package:hotel_reservation_app/ui/reservation/view/reservation_screen.dart';
import 'package:hotel_reservation_app/widgets/navigation.dart';

final reservationProvider =
    ChangeNotifierProvider((ref) => ReservationProvider());

class ReservationProvider extends ChangeNotifier {
  BookingHotel bookingHotels = BookingHotel();

  List<BookingHotel> listBookingHotels = [];
  bool loader = true;

  Future confirmationBooking(list, BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      list.clear();
      await showResponseDialog(
        context: context,
        responseMessage: 'Confirmation Succsess',
        status: true,
      );
      notifyListeners();
    });
  }

  Future removeItem(List list, int index) async {
    list.removeAt(index);
    notifyListeners();
  }

  void addBookingHotel({
    String? hotelName,
    String? image,
    int? bookingRooms,
    int? totalPrice,
    String? id,
    required BuildContext context,
  }) {
    loader = true;
    BookingHotel book = BookingHotel(
        bookingRooms: bookingRooms,
        hotelName: hotelName,
        id: id,
        image: image,
        totalPrice: totalPrice);
    listBookingHotels.add(book);
    loader = false;
    notifyListeners();
    navigateTo(
        context,
        const ReservationScreen(
            // hotel: null,
            ));
  }
}
