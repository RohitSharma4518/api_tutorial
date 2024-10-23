import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionController {
  // Created private Named Constructor
  SessionController._internal();

  // created an object the private named constructor
  static final SessionController _instance = SessionController._internal();

  // created a getter method to access this instance
  static SessionController get instance => _instance;

  final storage = const FlutterSecureStorage();

  // This can also be made a user model
  String? userId;
  String? token;
  DateTime? expiryDate;

  void setSession(String userId, String token, DateTime expiryDate) async {
    this.userId = userId;
    this.token = token;
    this.expiryDate = expiryDate;

    await storage.write(key: 'userId', value: userId);
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'expiryDate', value: expiryDate.toIso8601String());
  }

  Future<void> loadSession() async {
    final response = await Future.wait(
      [
        storage.read(key: 'userId'),
        storage.read(key: 'token'),
        storage.read(key: 'expiryDate'),
      ],
    );

    userId =  response[0];
    token = response[1];
    String? expiryDatestring = response[2];

    if (expiryDatestring != null) {
      expiryDate = DateTime.parse(expiryDatestring);
    }
  }

  void clearSession() async {
    userId = null;
    token = null;
    expiryDate = null;

    await Future.wait([
      storage.delete(key: 'userId'),
      storage.delete(key: 'token'),
      storage.delete(key: 'expiryDate'),
    ]);
  }
}
