import 'dart:convert';
import 'dart:math';

import 'package:api_tutorial/Screens/task_model.dart';
import 'package:api_tutorial/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddTask extends StatefulWidget {
  final TaskModel? todo;
  const AddTask({super.key, this.todo});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    final singleTodoInstance = widget.todo;
    super.initState();
    if (singleTodoInstance != null) {
      isEdit = true;
      titleController.text = singleTodoInstance.title;
      descriptionController.text = singleTodoInstance.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Todo' : "Add Todo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.lightGreen),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              child: Text(isEdit ? 'Update Task' : "Add Task"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    final todoId = widget.todo?.id;

    final title = titleController.text;
    final description = descriptionController.text;
    final sendData = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    // Submit the data to the server
    final response = await http.put(
        Uri.parse('https://api.nstack.in/v1/todos/$todoId'),
        body: jsonEncode(sendData),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 201) {
      showSuccessMessage("Updated Successfull");
      navigateToHome();
    } else {
      print('Update Failed');
      print(response.body);
    }
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final sendData = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    // Submit the data to the server
    final response = await http.post(
        Uri.parse('https://api.nstack.in/v1/todos'),
        body: jsonEncode(sendData),
        headers: {
          'Content-Type': 'application/json',
        });
    // Show Success and Fail Message to the User
    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage("Creation Successfull");
      navigateToHome();
    } else {
      print('Creation Failed');
      print(response.body);
    }
  }

  void showSuccessMessage(String msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToHome() {
    Get.back();
  }
}
