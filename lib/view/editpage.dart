import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/updatetudo.dart';

import '../controller/addcontroller.dart';
import '../services/apiconnections.dart';

class UpdateItemPage extends StatefulWidget {
  final String itemId;
  final String title;
  final String description; // Pass the ID of the item to be updated
  UpdateItemPage(
      {required this.itemId, required this.title, required this.description});

  @override
  State<UpdateItemPage> createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final tudodata = Provider.of<Updatetudo>(context,listen: false);
    tudodata.titleController.text = widget.title;
    tudodata.descriptionController.text = widget.description;
  }


  @override
  Widget build(BuildContext context) {
    final tudodata = Provider.of<Updatetudo>(context);
    tudodata.updateItem;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "EDIT ITEM",
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
                  onPressed: () {
                    tudodata.updateItem(context, widget.itemId, 
                      );
                  },
                  child: Text("UPDATE",
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
