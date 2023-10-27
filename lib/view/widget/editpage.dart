import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditTodo extends StatefulWidget {
  final Map? todo;
  final String title;
  final String decription;
  final String id;
  const EditTodo(
      {super.key,
      this.todo,
      required this.decription,
      required this.title,
      required this.id});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  TextEditingController Titlecontroller = TextEditingController();
  TextEditingController Decriptioncontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Titlecontroller.text = widget.title;
    Decriptioncontroller.text = widget.decription;
    // String id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    // String id = widget.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Edit ITEM",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: Titlecontroller,
            decoration: InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: Decriptioncontroller,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(hintText: "Decprition"),
            // minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          MaterialButton(
              color: Colors.black,
              onPressed: updateTodo,
              child: Text("UPDATE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.blue)))
        ],
      ),
    );
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

 Future<void> updateTodo() async {
  final id = widget.id;
  final title = Titlecontroller.text;
  final description = Decriptioncontroller.text;
  print(id);
  print(title);
  print(description);
  final body = {
    "title": title,
    "description": description,
    "is_completed": false,
  };
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.put( // Change http.post to http.put
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    showSuccessMessage('Update successful');
    print("Update success");
  } else {
    print("Update Error");
    showErrorMessage('Update Error');
    print(response.body);
  }
}

}
