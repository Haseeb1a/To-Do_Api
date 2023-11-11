import 'package:flutter/material.dart';
import 'package:todoapp/controller/home_controller.dart';

import '../services/api_connections.dart';

class Updatetudo extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  void updateItem(
    context,
    String itemIds,
  ) async {
    final String itemId = itemIds;
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (itemId.isNotEmpty && title.isNotEmpty && description.isNotEmpty) {
      // Call the updateItem method to update the item on the server
      await ApiService().updateItem(context, itemId, title, description);
      Homedata().refreshData();
      // Handle success and error cases, e.g., show a confirmation dialog.
    } else {
      return;
      // Handle validation errors or show a message to the user.
    }
  }
}
