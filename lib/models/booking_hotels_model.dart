
class AllBookingHotels {
  List<BookingHotel>? allHotels;

  AllBookingHotels({this.allHotels});

  AllBookingHotels.fromJson(List<dynamic> json) {
    allHotels = <BookingHotel>[];
    allHotels = json.map((k) => BookingHotel.fromJson(k)).toList();
  }

   

}

class BookingHotel{

   String? hotelName;
  String? image;
  int? bookingRooms;
  int? totalPrice;
  String? id;

  BookingHotel({
    this.hotelName,
    this.image,
    this.bookingRooms,
    this.totalPrice,
    this.id,
  });

  BookingHotel.fromJson(Map<String, dynamic> json) {
    hotelName = json['hotel_name'];
    image = json['image'];
    bookingRooms = json['booking_rooms'];
    totalPrice = json['total_price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson(data) {
    // final Map<String, dynamic> data = Map<String, dynamic>();
    data['hotel_name'] = hotelName;
    data['image'] = image;
    data['booking_rooms'] = bookingRooms;
    data['total_price'] = totalPrice;
    data['id'] = id;
    return data;
  }
}
