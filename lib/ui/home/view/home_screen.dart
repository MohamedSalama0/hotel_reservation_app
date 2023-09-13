import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/models/hotels_model.dart';
import 'package:hotel_reservation_app/ui/details_page/view/details_screen.dart';
import 'package:hotel_reservation_app/ui/home/controller/state/home_provider.dart';
import 'package:hotel_reservation_app/widgets/navigation.dart';

class AppNavigationBar extends ConsumerStatefulWidget {
   const AppNavigationBar({super.key,});

  @override
  ConsumerState<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends ConsumerState<AppNavigationBar> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).featchAllData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(homeProvider);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                label: 'Reservation',
              ),
            ],
            currentIndex: prov.selectedIndex,
            onTap: (index) {
              prov.onItemTapped(index);
            }),
        body: prov.pages[prov.selectedIndex]);
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var w = MediaQuery.sizeOf(context).width;
    var h = MediaQuery.sizeOf(context).height;

    final List<Hotel> list = ref.watch(homeProvider).hotels;
    return SafeArea(
      child: list.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    navigateTo(context, DetailsScreen(hotel: list[index]));
                  },
                  child: Card(
                    child: SizedBox(
                      height: h * .09,
                      width: w * 0.10,
                      // color: Colors.brown[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRect(
                          child: Stack(children: [
                            Row(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Image.network(
                                    /// ![with one single request MockAPI givven a one Image URL for all items]
                                    list.isEmpty
                                        ? ''
                                        : list[index].image.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: w * 0.05),
                                Column(
                                  children: [
                                    Text(
                                      list.isEmpty
                                          ? 'Empty'
                                          : list[index].hotelName.toString(),
                                    ),
                                    Text(
                                        'Available Rooms: ${list[index].rooms}')
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
