class User {
  String? id;
  String? username;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  int? creditCardNumber;
  String? rate;
  String? specialization;
  String? phoneNumber;
  String? image;
  int? experience;
  String? roles;
  bool isVerified;
  bool isBanned;

  String? token;
  String? resetToken;
  DateTime? resetTokenExpiration;
  String? otpCode;
  DateTime? otpExpiration;


  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.creditCardNumber,
    this.rate = 'GOOD',
    this.specialization,
    this.phoneNumber,
    this.image,
    this.experience,
    this.roles = 'admin',
    this.isVerified = false,
    this.isBanned = false,

    this.token,
    this.resetToken,
    this.resetTokenExpiration,
    this.otpCode,
    this.otpExpiration,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id:json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      creditCardNumber: json['creditCardNumber'],
      rate: json['rate'],
      specialization: json['specialization'],
      phoneNumber: json['phoneNumber'],
      image: json['image'],
      experience: json['experience'],
      roles: json['roles'],
      isVerified: json['isVerified'],
            isBanned: json['isBanned'],

      token: json['token'],
      resetToken: json['resetToken'],
      resetTokenExpiration: json['resetTokenExpiration'] != null
          ? DateTime.parse(json['resetTokenExpiration'])
          : null,
      otpCode: json['otpCode'],
      otpExpiration: json['otpExpiration'] != null
          ? DateTime.parse(json['otpExpiration'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'username': username,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'creditCardNumber': creditCardNumber,
      'rate': rate,
      'specialization': specialization,
      'phoneNumber': phoneNumber,
      'image': image,
      'experience': experience,
      'roles': roles,
      'isVerified': isVerified,
            'isBanned': isBanned,

      'token': token,
      'resetToken': resetToken,
      'resetTokenExpiration': resetTokenExpiration?.toIso8601String(),
      'otpCode': otpCode,
      'otpExpiration': otpExpiration?.toIso8601String(),
    };
  }
}