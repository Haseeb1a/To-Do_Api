import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/home_controller.dart';
import 'package:todoapp/view/list_todo.dart';

import '../controller/add_controller.dart';

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tudodata = Provider.of<AddTodo>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "ADD ITEM",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 230, 189)),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: tudodata.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: tudodata.titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: tudodata.descriptionController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    if (tudodata.formKey.currentState?.validate() ?? false) {
                      tudodata.addItem(context);
                      Homedata().refreshData();
                      tudodata.titleController.clear();
                      tudodata.descriptionController.clear();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemListWidget(),
                          ));
                    }
                  },
                  child: const Text(
                    "Add Task",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(255, 255, 230, 189),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
