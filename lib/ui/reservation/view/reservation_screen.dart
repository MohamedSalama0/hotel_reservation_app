import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/models/booking_hotels_model.dart';
import 'package:hotel_reservation_app/ui/reservation/controller/state/reservation_provider.dart';

class ReservationScreen extends StatefulWidget {
  // final Hotel hotel;
  const ReservationScreen({
    super.key,
  });

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    var h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(

          ),
      body: Consumer(
        builder: (context, ref, child) {
          List<BookingHotel> list =
              ref.watch(reservationProvider).listBookingHotels;
          final prov = ref.watch(reservationProvider);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: SizedBox(
                        height: h * .13,
                        width: double.infinity,
                        // color: Colors.brown[100],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRect(
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: Image.network(
                                        list[index].image.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: w * 0.05),
                                    Column(
                                      children: [
                                        Text(
                                          list[index].hotelName.toString(),
                                        ),
                                        Text(
                                            'Selected Rooms: ${list[index].bookingRooms}'),
                                        Text(
                                            "Total Price: ${list[index].totalPrice} EG ")
                                      ],
                                    ),
                                    Expanded(
                                      child: FittedBox(
                                        child: IconButton(
                                            iconSize: 14,
                                            onPressed: () {
                                              prov.removeItem(list, index);
                                            },
                                            icon: const Icon(
                                                Icons.clear_rounded)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  prov.confirmationBooking(list, context);
                },
                child: const Text('Confirmation booking'),
              ),
              SizedBox(
                height: h * 0.05,
              )
            ],
          );
        },
      ),
    );
  }
}
