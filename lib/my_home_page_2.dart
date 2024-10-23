import 'dart:convert';
import 'package:api_tutorial/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserModel> userDetails = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: userDetails.length,
          itemBuilder: (context, index) {
            final user = userDetails[index];
            return ListTile(
              // title: Text(user.fullName),
              title: Text(user.dob.date.toString()),
              leading: Text(user.name.first),
              // leading: CircleAvatar(
              //   child: ClipRRect(
              //       borderRadius: BorderRadius.circular(30),
              //       child: Image.network(userDetails[index].gender)),
              // ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(eccentricity: 0),
        elevation: 40,
        backgroundColor: Colors.teal,
        onPressed: () {
          fetchUsers();
          // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
    );
  }

  Future<void> fetchUsers() async {
    const String url = "https://randomuser.me/api/?results=10";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body; // Parsed as String
    print(body.runtimeType);
    final json = jsonDecode(body);
    print("Json Decoded from String to Json = $json");
    print("Json variable TYPE = ${json.runtimeType}");
    final intermediateData = json['results'] as List<dynamic>;
    print("Converted to List of dynamic $intermediateData");
    final userDetailsThroughModel = intermediateData.map(
      (e) {
        return UserModel.fromMap(e);
      },
    ).toList();

    print(userDetailsThroughModel);
    print(json.runtimeType);
    print(json);
    setState(() {
      userDetails = userDetailsThroughModel;
    });
    print(userDetails.runtimeType);
  }
}
