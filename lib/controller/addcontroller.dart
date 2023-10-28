import 'package:flutter/material.dart';
import '../services/apiconnections.dart';

class AddTodo extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  void addItem(context) async {
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      // Call the postNewItem method to post the item to the server
      await ApiService().submitdata(context,title, description);
      ChangeNotifier();
      // You can also handle success and error cases here, e.g., show a confirmation dialog
      // or navigate back to the previous page.
    } else {
      // Handle validation errors or show a message to the user.
    }
  }
}
