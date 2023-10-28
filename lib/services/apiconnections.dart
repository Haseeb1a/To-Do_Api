import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todoapp/model/tudomodel.dart';
import 'package:todoapp/view/widget/snakbar.dart';

class ApiService {
  static Future<Tudomodel> fetchDataFromAPI() async {
    final url =
        'https://api.nstack.in/v1/todos?page=1&limit=10'; // Replace with the actual API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return tudomodelFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> submitdata(context, String title, String description) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    final url = 'https://api.nstack.in/v1/todos';
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
      // showSuccessMessage();

      // showSuccessMessage
      print("Creaation Success");
      showSuccess(context, " Creaation Success");
      fetchDataFromAPI();
      // Show().showSuccess (," Creaation Success");
    } else {
      print("Creaation Error");
      // showErrorMessage();
      print(responce.body);
            showError(context, "Creaation Error");
      // showerror(" Creaation Success");
    }
  }

  Future<void> deleteItem(ctx, String itemId) async {
    final url = Uri.parse(
        'https://api.nstack.in/v1/todos/$itemId'); // Replace with your actual API endpoint and item ID

    final response = await http.delete(
      url,
      headers: {
        'Content-Type':
            'application/json', // Specify the content type if needed
      },
    );

    if (response.statusCode == 200) {
      // Item successfully deleted (status code 200 - OK)
      print('Item deleted successfully');
      showError(ctx, 'Item deleted successfully');
      fetchDataFromAPI();
    } else {
      // Handle the error if the request fails
      print('Error deleting item: ${response.statusCode} - ${response.body}');
      
    }
  }

  Future<void> updateItem(
      context, String itemId, String title, String description) async {
    final url = Uri.parse(
        'https://api.nstack.in/v1/todos/$itemId'); // Replace with your actual API endpoint and item ID

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
      // Item successfully updated (status code 200 - OK)
      print('Item updated successfully');

      showSuccess(context, 'Item updated successfully');
    } else {
      // Handle the error if the request fails
      print('Error updating item: ${response.statusCode} - ${response.body}');
      showError(context, "Error updating item");
    }
  }
}
