import 'dart:convert';

import 'package:api_tutorial/Screens/add_task.dart';
import 'package:api_tutorial/Screens/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  @override
  void initState() {
    super.initState();
    getTodoItems();
  }

  bool isLoading = true;

  List<TaskModel> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text(
          "Todo List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: getTodoItems,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final singleItems = items[index];
              return isLoading
                  ? CircularProgressIndicator()
                  : Card(
                      color: Colors.amber,
                      child: ListTile(
                          leading: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.black,
                            ),
                          ),
                          title: Text('${singleItems.title}'),
                          subtitle: Text("${singleItems.description}"),
                          trailing: PopupMenuButton(
                              onSelected: (value) {
                                if (value == "Edit") {
                                  // Go to Edit Page
                                  navigateToEditPage(singleItems);
                                } else if (value == "Delete") {
                                  // Delete Item
                                  deleteById(singleItems.id);
                                }
                              },
                              position: PopupMenuPosition.under,
                              color: Colors.black,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: "Edit",
                                  ),
                                  PopupMenuItem(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: "Delete",
                                  ),
                                ];
                              })),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyanAccent,
        label: const Text(
          'Add Todo',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        onPressed: navigateToAddPage,
      ),
    );
  }

  Future<void> deleteById(String id) async {
    final response =
        await http.delete(Uri.parse('https://api.nstack.in/v1/todos/$id'));
    // getTodoItems();
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element.id != id).toList();
      setState(() {
        items = filtered;
      });
    }
  }

  Future<void> navigateToEditPage(TaskModel item) async {
    await Get.to(() => AddTask(todo: item));
    setState(() {
      isLoading = true;
    });
    getTodoItems();
  }

  Future<void> navigateToAddPage() async {
    await Get.to(() => AddTask());
    setState(() {
      isLoading = true;
    });
    getTodoItems();
  }

  Future<void> getTodoItems() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10'),
    );

    final json = jsonDecode(response.body);
    final result = json['items'] as List<dynamic>;
    final toModelResult = result.map(
      (e) {
        return TaskModel.fromMap(e);
      },
    ).toList();
    if (response.statusCode == 200) {
      setState(() {
        items = toModelResult;
      });
    } else {
      print(response.statusCode);
    }

    print(items);
    setState(() {
      isLoading = false;
    });
  }
}
