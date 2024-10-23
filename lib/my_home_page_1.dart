// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<dynamic> userDetails = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//           itemCount: userDetails.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(userDetails[index]['name']['first']),
//               leading: CircleAvatar(
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(30),
//                     child: Image.network(
//                         userDetails[index]['picture']['thumbnail'])),
//               ),
//             );
//           }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: fetchUsers,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> fetchUsers() async {
//     const String url = "https://randomuser.me/api/?results=10";
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     print(body.runtimeType);
//     final json = jsonDecode(body);
//     print(json.runtimeType);
//     userDetails = json['results'];
//     // 
//     print(userDetails.runtimeType);
//     print(userDetails[0]['name']);
//   }
// }
