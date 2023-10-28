// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/homecontroller.dart';
import 'package:todoapp/services/apiconnections.dart';
import 'package:todoapp/view/add_todo.dart';
import 'package:todoapp/view/list.todo.dart';
import 'package:todoapp/view/editpage.dart';

import 'controller/addcontroller.dart';
import 'controller/updatetudo.dart';
import 'model/tudomodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AddTodo()),
        ChangeNotifierProvider(create: (context)=>Updatetudo()),
        ChangeNotifierProvider(create: (context)=>Homedata())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ItemListWidget(),
        ),
      ),
    );
  }
}


