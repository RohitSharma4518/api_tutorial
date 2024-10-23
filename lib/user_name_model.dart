class UserNameModel {
  final String first;
  final String last;
  final String title;

  UserNameModel({
    required this.first,
    required this.last, 
    required this.title,
  });

  factory UserNameModel.fromMap(Map<String, dynamic> json) {
    return UserNameModel(
      first: json['first'],
      last: json['last'],
      title: json['title'],
    );
  }
}
