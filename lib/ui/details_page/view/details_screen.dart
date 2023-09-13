import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/models/hotels_model.dart';
import 'package:hotel_reservation_app/ui/details_page/controller/state/details_provider.dart';
import 'package:hotel_reservation_app/ui/reservation/controller/state/reservation_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Hotel hotel;
  const DetailsScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    var h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Hotel Information')),
      body: Column(
        children: [
          Image.network(
            hotel.image.toString(),
            fit: BoxFit.fill,
          ),
          SizedBox(height: h * 0.05),
          Text(hotel.hotelName.toString()),
          SizedBox(height: h * 0.05),
          Text('Available Rooms: ${hotel.rooms}'),
          SizedBox(height: h * 0.05),
          Text('room price: ${hotel.roomPrice}'),
          SizedBox(height: h * 0.05),
          Consumer(
            builder: (context, ref, child) {
              final prov = ref.watch(detailsProvider);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      IconButton(
                      onPressed: () {
                        prov.decrease();
                      },
                      icon: const Icon(Icons.exposure_minus_1)),
                  SizedBox(width: w * 0.03),
                  Text(prov.counter.toString()),
             
                       IconButton(
                      onPressed: () {
                        prov.increase(hotel.rooms!);
                      },
                      icon: const Icon(Icons.plus_one)),
                ],
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final prov = ref.watch(detailsProvider);

              return ElevatedButton(
                onPressed: () {
                  ref.read(reservationProvider.notifier).addBookingHotel(
                   bookingRooms: prov.counter,
                   hotelName:hotel.hotelName ,
                   id: hotel.id,
                   totalPrice: (prov.counter*hotel.roomPrice!),
                   image: hotel.image, context: context,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: const Text('Booking'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
