// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/home_controller.dart';
import 'package:todoapp/view/list_todo.dart';
import 'controller/add_controller.dart';
import 'controller/update_tudo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddTodo()),
        ChangeNotifierProvider(create: (context) => Updatetudo()),
        ChangeNotifierProvider(create: (context) => Homedata())
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ItemListWidget(),
        ),
      ),
    );
  }
}
