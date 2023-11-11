import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/home_controller.dart';
import 'package:todoapp/helpers/colors.dart';
import 'package:todoapp/view/add_todo.dart';
import 'package:todoapp/view/edit_page.dart';
import '../model/tudo_model.dart';
import 'package:typethis/typethis.dart';

class ItemListWidget extends StatefulWidget {
  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  void initState() {
    final homedatas = Provider.of<Homedata>(context, listen: false);
    homedatas.refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homedatas = Provider.of<Homedata>(context);
    return Scaffold(
      backgroundColor: AppCollors.primarytheme,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:AppCollors.darktheme,
              title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TODO ',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 230, 189),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'LIST',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: homedatas.refreshData,
        child: FutureBuilder<Tudomodel>(
          future: homedatas.data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final items = snapshot.data!.items;
    
              if (items.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: AppCollors.primarytheme,
                      child: Image.asset('assets/emptyog.png'),
                    ),
                    // Lottie.asset('assets/data.json'),
                    const TypeThis(
                      showBlinkingCursor: true,
                      string: ' Empty List ',
                      speed: 75,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppCollors.darktheme,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ));
              }
    
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    color: AppCollors.darktheme,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:AppCollors.primarytheme,
                        child: Text("${index + 1}",style: TextStyle(color:AppCollors.darktheme),),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold,color:const Color.fromARGB(255, 255, 230, 189)),
                      ),
                      subtitle: Text(
                        item.description,
                        style: const TextStyle(fontWeight: FontWeight.bold,color: AppCollors.primarytheme),
                      ),
                      trailing: PopupMenuButton(
                        color: Colors.white,
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Image.asset('assets/empty.jpg'),
                  ),
                  // Lottie.asset('assets/Animation - 1699526185617.json'),
                  const Center(child: Text('No data available')),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppCollors.darktheme,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemPage(),
            ),
          );
        },
        label: const Text(
          "ADD TODO",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: AppCollors.primarytheme),
        ),
      ),
    );
  }
}
