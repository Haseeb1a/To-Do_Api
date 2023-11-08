import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/updatetudo.dart';
import 'package:todoapp/view/list.todo.dart';

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
    super.initState();
    final tudodata = Provider.of<Updatetudo>(context, listen: false);
    tudodata.titleController.text = widget.title;
    tudodata.descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    final tudodata = Provider.of<Updatetudo>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "EDIT ITEM",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: tudodata.formKey,
              child: TextFormField(
                controller: tudodata.titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Enter the title";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            TextFormField(
              controller: tudodata.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Please enter the Description";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: MaterialButton(
                color: Colors.black,
                onPressed: () {
                  if (tudodata.formKey.currentState?.validate() ?? false) {
                    tudodata.updateItem(
                      context,
                      widget.itemId,
                    );
                  }
                },
                child: const Text(
                  "UPDATE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
