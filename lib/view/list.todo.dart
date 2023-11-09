import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/homecontroller.dart';
import 'package:todoapp/view/add_todo.dart';
import 'package:todoapp/view/editpage.dart';
import '../model/tudomodel.dart';
import '../services/apiconnections.dart';

class ItemListWidget extends StatefulWidget {
  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  void initState() {
    final homedatas = Provider.of<Homedata>(context, listen: false);
    homedatas.refreshData();
    // TODO: implement initState
    super.initState();
  }

  // Future<Tudomodel>? _data;
  @override
  Widget build(BuildContext context) {
    final homedatas = Provider.of<Homedata>(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 35, 36),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: const Text(
            "TODO LIST",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: homedatas.refreshData,
          child: FutureBuilder<Tudomodel>(
            future: homedatas.data,
            builder: (contextl, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data != null) {
                print('hdkjghkhs');
                final items = snapshot.data!.items;

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
                        title: Text(
                          item.title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          item.description,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateItemPage(
                                    itemId: item.id,
                                    description: item.description,
                                    title: item.title,
                                  ),
                                ),
                              );
                            } else if (value == 'delete') {
                              homedatas.deleteitems(context, item.id);
                              // Refresh the list after deletion
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                child: Text("Edit"),
                                value: 'edit',
                              ),
                              const PopupMenuItem(
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
              } else {
                return Center(
                  child: Text('No data available'),
                );
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
            label: const Text(
              "ADD TODO",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.blue),
            )));
  }
}
