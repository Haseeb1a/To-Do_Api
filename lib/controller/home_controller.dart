import 'package:flutter/material.dart';
import 'package:todoapp/view/list_todo.dart';

import '../model/tudo_model.dart';
import '../services/api_connections.dart';

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

  deleteitems(BuildContext context, itemid){
    ApiService().deleteItem(context, itemid);
    refreshData();
    // data;
    notifyListeners();
  }
}
