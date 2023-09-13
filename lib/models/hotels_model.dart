class Hotels {
  List<Hotel>? allHotels;

  Hotels({this.allHotels});

  Hotels.fromJson(List<dynamic> json) {
    print('1 $json');
    allHotels = <Hotel>[];
    allHotels = json.map((k) => Hotel.fromJson(k)).toList();
    print('2 ${allHotels?[0].hotelName}');
  }
}

class Hotel {
  String? hotelName;
  String? image;
  int? rooms;
  int? roomPrice;
  String? id;

  Hotel({
    this.hotelName,
    this.image,
    this.rooms,
    this.roomPrice,
    this.id,
  });

  Hotel.fromJson(Map<String, dynamic> json) {
    hotelName = json['hotel_name'];
    image = json['image'];
    rooms = json['rooms'];
    roomPrice = json['room_price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson(data) {
    // final Map<String, dynamic> data = Map<String, dynamic>();
    data['hotel_name'] = hotelName;
    data['image'] = image;
    data['rooms'] = rooms;
    data['room_price'] = roomPrice;
    data['id'] = id;
    return data;
  }
}



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
