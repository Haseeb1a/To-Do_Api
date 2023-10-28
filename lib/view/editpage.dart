import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/updatetudo.dart';

import '../controller/addcontroller.dart';
import '../services/apiconnections.dart';

class UpdateItemPage extends StatelessWidget {
  final String itemId; // Pass the ID of the item to be updated
  UpdateItemPage({required this.itemId});

  @override
  Widget build(BuildContext context) {
        final tudodata = Provider.of<Updatetudo>(context);
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
              controller: tudodata.titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: tudodata.descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 20),
           Center(
          child: MaterialButton(
              color: Colors.black,
              
              
              onPressed:() {
                tudodata.updateItem(context,itemId);
              },
              
               child: Text("UPDATE", style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 17, color: Colors.blue))),
        )
          ],
        ),
      ),
    );
  }
}
