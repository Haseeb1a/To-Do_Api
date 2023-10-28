import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/homecontroller.dart';
import 'package:todoapp/view/add_todo.dart';
import 'package:todoapp/view/editpage.dart';

import '../controller/homecontroller.dart';
import '../model/tudomodel.dart';
import '../services/apiconnections.dart';

class ItemListWidget extends StatelessWidget {
  // Future<Tudomodel>? _data;
  @override
  Widget build(BuildContext context) {
    final homedatas = Provider.of<Homedata>(context);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 35, 35, 36),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "TODO LIST",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: homedatas.refreshData,
          child: FutureBuilder<Tudomodel>(
            future:  homedatas.data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data != null) {
                final items = snapshot.data!.items;
                if (items.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text("${index + 1}"),
                          ),
                          title: Text(item.title),
                          subtitle: Text(item.description),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateItemPage(itemId: item.id),
                                  ),
                                );
                              } else if (value == 'delete') {
                                ApiService().deleteItem(item.id);
                                homedatas.refreshData(); // Refresh the list after deletion
                              }
                            },
                            itemBuilder: (context) {
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
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemPage(),
                  ));
            },
            label: Text(
              "ADD TODO",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.blue),
            )));
  }
}
