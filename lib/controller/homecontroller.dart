import 'package:flutter/material.dart';
import 'package:todoapp/view/list.todo.dart';

import '../model/tudomodel.dart';
import '../services/apiconnections.dart';

class Homedata extends ChangeNotifier {
  Future<Tudomodel>? data;

  Future<void> refreshData() async {
    data = ApiService.fetchDataFromAPI();
    await data; // Wait for the data to be fetched
    notifyListeners();
  }

  // You should await the data fetch in the constructor as well
  Homedata() {
    refreshData();
    notifyListeners();
  }

  // Future<void> startup() async {
  //   data = ApiService.fetchDataFromAPI();
  //   await data; // Wait for the data to be fetched
  //   notifyListeners();
  // }
}
