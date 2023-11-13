import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/home_controller.dart';
import 'package:todoapp/controller/update_tudo.dart';
import 'package:todoapp/helpers/colors.dart';
import 'package:todoapp/view/list_todo.dart';

class UpdateItemPage extends StatefulWidget {
  final String itemId;
  final String title;
  final String description; // Pass the ID of the item to be updated
  UpdateItemPage(
      {required this.itemId, required this.title, required this.description,});

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
      backgroundColor: AppCollors.darktheme,
      appBar: AppBar(
        backgroundColor: AppCollors.darktheme,
        title: const Text.rich(TextSpan(children: <InlineSpan>[
          TextSpan(
            text: 'EDIT ',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppCollors.primarytheme),
          ),
          TextSpan(
            text: 'ITEM',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ])),
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'Title',
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: tudodata.descriptionController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)),
                hintText: 'Description',
              ),
              maxLines: 5,
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppCollors.darktheme,
                    side: BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  if (tudodata.formKey.currentState?.validate() ?? false) {
                    tudodata.updateItem(
                      context,
                      widget.itemId,
                    );
                    Homedata().refreshData();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemListWidget(),
                        ));
                  }
                },
                child: const Text(
                  "UPDATE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color.fromARGB(255, 255, 230, 189),
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
