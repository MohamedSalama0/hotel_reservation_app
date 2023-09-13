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


