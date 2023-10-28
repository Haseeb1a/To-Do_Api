import 'package:flutter/material.dart';

import '../services/apiconnections.dart';

class Updatetudo extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  void updateItem(String itemIds) async {
    final String itemId = itemIds;
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (itemId.isNotEmpty && title.isNotEmpty && description.isNotEmpty) {
      // Call the updateItem method to update the item on the server
      await ApiService().updateItem(itemId, title, description);
      // Handle success and error cases, e.g., show a confirmation dialog.
    } else {
      return;
      // Handle validation errors or show a message to the user.
    }
  }
}