import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/addcontroller.dart';

class AddItemPage extends StatelessWidget {
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
                  onPressed: (){
                    tudodata.addItem(context);
                  },
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
