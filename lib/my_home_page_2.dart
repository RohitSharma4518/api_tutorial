import 'dart:convert';
import 'package:api_tutorial/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  List<UserModel> userDetails = [];
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _isLoading
          ? ListView.builder(
              itemCount: userDetails.length,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    title: Container(
                      width: 200,
                      height: 20,
                      color: Colors.white,
                    ),
                    subtitle: Container(
                      width: 150,
                      height: 14,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: userDetails.length,
              itemBuilder: (context, index) {
                final user = userDetails[index];
                return ListTile(
                  title: Text(user.fullName),
                  leading: Text(user.name.first),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(eccentricity: 0),
        elevation: 40,
        backgroundColor: Colors.teal,
        onPressed: () {
          fetchUsers();
        },
        tooltip: 'Fetch Users',
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
    );
  }

  Future<void> fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    const String url = "https://randomuser.me/api/?results=4";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);

    final intermediateData = json['results'] as List<dynamic>;
    final userDetailsThroughModel = intermediateData.map((e) {
      return UserModel.fromMap(e);
    }).toList();

    setState(() {
      _isLoading = false;
      userDetails = userDetailsThroughModel;
    });
  }
}
