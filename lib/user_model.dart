import 'package:api_tutorial/user_dob_model.dart';
import 'package:api_tutorial/user_name_model.dart';

class UserModel {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserNameModel name;
  final UserDobModel dob;

  UserModel({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.dob,
  });

  factory UserModel.fromMap(Map<String, dynamic> e) {
    final dob = UserDobModel.fromMap(e['dob']);
    final name = UserNameModel.fromMap(e['name']);
    return UserModel(
      gender: e['gender'],
      email: e['email'],
      phone: e['phone'],
      cell: e['cell'],
      nat: e['nat'],
      name: name,
      dob: dob,
    );
  }

  String get fullName {
    return '${name.title} ${name.first} ${name.last}';
  }
}


// Future<void> fetchCategory() async {
//     // you can replace your api link with this link
//     var headers = {
//       'Authorization': '${GetStorage().read('token')}',
//       // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5laGlsQGdtYWlsLmNvbSIsInVzZXJJZCI6IjY1NzZhYzcwMzhmN2ExY2M1N2I1MTE0NiIsImlhdCI6MTcwMjI3NjY0MX0.fmHtUARR-nHkar5UsibOFVcT5AgEDiWTSkq39sC6GQg',
//       'Content-Type': 'application/json',
//     };
//     print("this is fetch function");
//     print(
//         "Request URL: ${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getCategory}");

//     final response = await http.get(
//         Uri.parse(
//             ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getCategory),
//         headers: headers);
//     print("Response JSON: ${response.body}");

//     if (response.statusCode == 200) {
//       // Parse the full JSON response
//       Map<String, dynamic> jsonResponse = json.decode(response.body);
//       List<dynamic> jsonData = jsonResponse['data'];
//       categoryData =
//           jsonData.map((item) => CategoryData.fromJson(item)).toList();
//       print("categories Data is here = $categoryData");
//     } else {
//       // Handle error if needed
//       print("Error: ${response.statusCode}, Body: ${response.body}");
//     }
//   }