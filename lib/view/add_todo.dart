import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/addcontroller.dart';
import 'package:http/http.dart' as http;

class AddTodo extends StatefulWidget {
  final Map? todo;
  const AddTodo({super.key,this.todo});

  @override
  State<AddTodo> createState() => AddTodoState();
}

class AddTodoState extends State<AddTodo> {
  TextEditingController Titlecontroller = TextEditingController();
  TextEditingController Decriptioncontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo=widget.todo;
    if(todo!=null){
      final title=todo['title'];
      final description=todo['description'];
      Titlecontroller.text=title;
      Decriptioncontroller.text=description;

    }


  }
  @override
  Widget build(BuildContext context) {
    final addData = Provider.of<Addcontoller>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,

        title: const Text("ADD ITEM",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
        
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
            
            onPressed: submitdata, child: Text("Add Task", style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.blue)))
        ],
      ),
    );
  }
  Future<void> submitdata() async {
    final title = Titlecontroller.text;
    final description = Decriptioncontroller.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    final  url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final responce = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    print(responce.statusCode);
    print(responce.body);
    if (responce.statusCode == 201) {
      Titlecontroller.clear;
      Decriptioncontroller.clear;
      showSuccessMessage();

      // showSuccessMessage
      print("Creation sucuss");
    } else {
      print("Creaation Error");
      showErrorMessage();
      print(responce.body);
    }
  }
  void showErrorMessage() {
    final snackBar = SnackBar(content: Text('jghfgh'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage() {
    final snackBar = SnackBar(content: Text('jhgd'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
