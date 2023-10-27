import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/addcontroller.dart';
import 'package:todoapp/view/list.todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Addcontoller())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TodoList(),
      ),
    );
  }
}
// -----------------------------279-15.57


