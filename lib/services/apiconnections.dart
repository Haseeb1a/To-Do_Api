import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todoapp/model/tudomodel.dart';
import 'package:todoapp/view/widget/snakbar.dart';

class ApiService {
  // get-----------------------
  static Future<Tudomodel> fetchDataFromAPI() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return tudomodelFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

// Post-------------------------------------------
  Future<void> submitdata(context, String title, String description) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final responce = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    print(responce.statusCode);
    print(responce.body);
    if (responce.statusCode == 201) {
      print("ss");
      print("Creaation Success");
      showSuccess(context, " Creaation Success");
      fetchDataFromAPI();
    } else {
      print("Creaation Error");
      print(responce.body);
       showError(context, "Creaation Error");
    }
  }

  //delete ---------------------------------------------------
  Future<void> deleteItem(ctx, String itemId) async {
    final url = Uri.parse(
        'https://api.nstack.in/v1/todos/$itemId'); 

    final response = await http.delete(
      url,
      headers: {
        'Content-Type':
            'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Item deleted successfully');
      showError(ctx, 'Item deleted successfully');
      // fetchDataFromAPI();
    } else {
     
      print('Error deleting item: ${response.statusCode} - ${response.body}');
    }
  }

//  put-------------------------
  Future<void> updateItem(
      context, String itemId, String title, String description) async {
    final url = Uri.parse('https://api.nstack.in/v1/todos/$itemId');

    final Map<String, String> data = {
      "title": title,
      "description": description,
    };

    final response = await http.put(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
     
      print('Item updated successfully');

      showSuccess(context, 'Item updated successfully');
    } else {

      print('Error updating item: ${response.statusCode} - ${response.body}');
      showError(context, "Error updating item");
    }
  }
}
