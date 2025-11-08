class Beneficiary {
  final int id;
  final String firstName;
  final String lastName;
  final String idNumber;
  final DateTime dateOfBirth;
  final String gender;
  final String relationship;
  final String? email;
  final String? phoneNumber;
  final String mainMemberId;

  Beneficiary({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.idNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.relationship,
    this.email,
    this.phoneNumber,
    required this.mainMemberId,
  });

  String get fullName => '$firstName $lastName';

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      idNumber: json['idNumber'] ?? '',
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'] ?? '',
      relationship: json['relationship'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      mainMemberId: json['mainMemberId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'idNumber': idNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'relationship': relationship,
      'email': email,
      'phoneNumber': phoneNumber,
      'mainMemberId': mainMemberId,
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'idNumber': idNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'relationship': relationship,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
    };
  }
}
