import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 2)
class AuthUser extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String? phoneNumber;

  @HiveField(5)
  String role;

  @HiveField(6)
  String? idNumber;

  @HiveField(7)
  DateTime? dateOfBirth;

  @HiveField(8)
  String? gender;

  @HiveField(9)
  String? address;

  AuthUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.role,
    this.idNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
  });

  String get fullName => '$firstName $lastName';

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'],
      role: json['role'] ?? '',
      idNumber: json['idNumber'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      gender: json['gender'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'role': role,
      'idNumber': idNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'address': address,
    };
  }
}

class AuthResponse {
  final AuthUser? user;
  final String? token;
  final String? refreshToken;
  final DateTime? expiresAt;

  AuthResponse({
    this.user,
    this.token,
    this.refreshToken,
    this.expiresAt,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    // Check if response has the wrapped format (isSuccess/value)
    if (json['value'] != null && json['isSuccess'] == true) {
      return AuthResponse(
        user: AuthUser.fromJson(json['value']),
        token: json['value']['token'] ?? json['value']['jwtToken'],
        refreshToken: json['value']['refreshToken'],
        expiresAt: json['value']['expiresAt'] != null
            ? DateTime.parse(json['value']['expiresAt'])
            : json['value']['refreshTokenExpiration'] != null
                ? DateTime.parse(json['value']['refreshTokenExpiration'])
                : null,
      );
    }

    // Handle direct response format (your API's actual format)
    if (json['jwtToken'] != null || json['token'] != null) {
      return AuthResponse(
        user: AuthUser.fromJson(json),
        token: json['jwtToken'] ?? json['token'],
        refreshToken: json['refreshToken'],
        expiresAt: json['refreshTokenExpiration'] != null
            ? DateTime.parse(json['refreshTokenExpiration'])
            : json['expiresAt'] != null
                ? DateTime.parse(json['expiresAt'])
                : null,
      );
    }

    return AuthResponse();
  }

  bool get isValid => user != null && token != null;
}
