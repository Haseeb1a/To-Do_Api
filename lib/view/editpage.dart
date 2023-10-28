import 'package:flutter/material.dart';

import '../services/apiconnections.dart';

class UpdateItemPage extends StatefulWidget {
  final String itemId; // Pass the ID of the item to be updated
  UpdateItemPage({required this.itemId});

  @override
  _UpdateItemPageState createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _updateItem() async {
    final String itemId = widget.itemId;
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (itemId.isNotEmpty && title.isNotEmpty && description.isNotEmpty) {
      // Call the updateItem method to update the item on the server
      await ApiService().updateItem(itemId, title, description);
      // Handle success and error cases, e.g., show a confirmation dialog.
    } else {
      // Handle validation errors or show a message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "EIT ITEM",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 20),
           Center(
          child: MaterialButton(
              color: Colors.black,
              
              
              onPressed: _updateItem, child: Text("UPDATE", style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 17, color: Colors.blue))),
        )
          ],
        ),
      ),
    );
  }
}
