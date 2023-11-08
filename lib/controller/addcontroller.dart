import 'package:flutter/material.dart';
import '../services/apiconnections.dart';

class AddTodo extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  void addItem(context) async {
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      // Call the postNewItem method to post the item to the server
      await ApiService().submitdata(context, title, description);
      ChangeNotifier();
    } else {}
  }
}
