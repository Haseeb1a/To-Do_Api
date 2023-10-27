import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/view/add_todo.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/view/widget/editpage.dart';
import '../controller/addcontroller.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isLoading = false;
  List items = [];
  @override
  void initState() {
    // final addData = Provider.of<Addcontoller>(context);
    fetchData();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    // final addData = Provider.of<Addcontoller>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 176, 139),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "TODO LIST",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchData,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text('No Todo Item',style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
              
            ),

            child: ListView.builder(
                itemCount: items.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  
                  final item = items[index];
                  final id = item['_id'] as String;
                  return Card (
                    
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text("${index + 1}"),
                      ),
                      title: Text(item['title']),
                      subtitle: Text(
                        item['description'],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: PopupMenuButton(onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTodo( decription: item['description'],title:item['title'] ,id: item['_id'], ),
                              ));
                        } else if (value == 'delete') {
                          deleteByid(id);
                        }
                      }, itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text("Edit"),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: Text('Delete'),
                            value: 'delete',
                          )
                        ];
                      }),
                    ),
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodo(),
                ));
          },
          label: Text(
            "ADD TODO",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue),
          )),
    );
  }

  Future<void> deleteByid(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final fittered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = fittered;
      });
    } else {
      showErrorMessage("Detection failed");
    }
  }

  Future<void> fetchData() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    print(responce.statusCode);
    print(responce.body);
    if (responce.statusCode == 200) {
      final json = jsonDecode(responce.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {}
    setState(() {
      isLoading = false;
    });
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
