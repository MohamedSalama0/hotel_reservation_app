import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final detailsProvider = ChangeNotifierProvider.autoDispose((ref) => DetailsProvider());

class DetailsProvider extends ChangeNotifier {
  int counter = 0;

  void increase(int maximum) {
    if (counter == maximum) return;
    counter++;
    notifyListeners();
  }

  void decrease() {
    if (counter == 0) return;
    counter--;
    notifyListeners();
  }
}
