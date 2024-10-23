class UserDobModel {
  final DateTime date;
  final int age;
  UserDobModel({
    required this.date,
    required this.age,
  });

  factory UserDobModel.fromMap(Map<String, dynamic> json){
    return UserDobModel(
      date: DateTime.parse(json['date']),
      age: json['age'],
    );
  }
}
