import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller copy/homepagecontroller.dart';

class AddItemPage extends StatelessWidget {
  // final TextEditingController titleController = TextEditingController();

  // final TextEditingController descriptionController = TextEditingController();

  // void _addItem() async {
  //   final String title = titleController.text;
  //   final String description = descriptionController.text;

  //   if (title.isNotEmpty && description.isNotEmpty) {
  //     // Call the postNewItem method to post the item to the server
  //     await ApiService().submitdata(title, description);
  //     // You can also handle success and error cases here, e.g., show a confirmation dialog
  //     // or navigate back to the previous page.
  //   } else {
  //     // Handle validation errors or show a message to the user.
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final tudodata = Provider.of<AddTodo>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "ADD ITEM",
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
              controller:tudodata. titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: tudodata.descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
            SizedBox(height: 20),
            Center(
              child: MaterialButton(
                  color: Colors.black,
                  onPressed: tudodata.addItem,
                  child: Text("Add Task",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.blue))),
            )
          ],
        ),
      ),
    );
  }
}
