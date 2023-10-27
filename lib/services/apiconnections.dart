import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todoapp/model/tudomodel.dart';

class Connections {
  List<Item> items = [];

final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  //   final uri = Uri.parse(url);
     Future<List<Map<String, dynamic>>?> getIsro() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> spaceList =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        return spaceList;
      } else {
        print("Failed to fetch space data. Status code: ${response.statusCode}");
        return null; // Return null or handle the error appropriately
      }
    } catch (error) {
      print("An error occurred: $error");
      rethrow;
    }
  }
  // Future<List<Item>> fetchData() async {
  //   final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  //   final uri = Uri.parse(url);
  //   final responce = await http.get(uri);
  //   print(responce.statusCode);
  //   print(responce.body);
  //   if (responce.statusCode == 200) {
  //     var body = jsonDecode(responce.body);
  //     items=

  //     return Item.fromJson(body);

  //     // final result = json['items'] as List;
  //     // // setState(() {
  //     // items = result;

  //     // });
  //   } else {
  //     throw Exception("error");
  //   }
    // setState(() {
    // isLoading = false;
    // });
  }

