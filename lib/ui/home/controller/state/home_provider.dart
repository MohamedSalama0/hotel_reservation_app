import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/models/hotels_model.dart';
import 'package:hotel_reservation_app/ui/home/controller/home_api.dart';
import 'package:hotel_reservation_app/ui/home/view/home_screen.dart';
import 'package:hotel_reservation_app/ui/reservation/view/reservation_screen.dart';

final homeProvider =
    ChangeNotifierProvider.autoDispose((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  List<Hotel> hotels = [];

  // HomeProvider(context){
  //   // featchAllData(context);
  // }

  Future featchAllData(BuildContext context) async {
    final Hotels? data =
        await HomeApi.getHotelsData(topLoader: true, context: context);
    if (data == null) return print('data reicevd null');
    hotels = data.allHotels!;
    notifyListeners();
  }

  void onItemTapped(int index) {
     selectedIndex = index;
    notifyListeners();
  }

  int selectedIndex = 0; 
  final List<Widget> pages = [
    const HomeScreen(),
    const ReservationScreen()
  ];
}
