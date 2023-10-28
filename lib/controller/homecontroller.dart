import 'package:flutter/material.dart';

import '../model/tudomodel.dart';
import '../services/apiconnections.dart';

class Homedata extends ChangeNotifier {
  Future<Tudomodel>? data;
  Future<void> refreshData() async {
    // setState(() {
    data = ApiService.fetchDataFromAPI();
    notifyListeners();
    // });
  }

  startup() {
    data = ApiService.fetchDataFromAPI();
    notifyListeners();
  }

  Homedata() {
    startup();
  }
}
