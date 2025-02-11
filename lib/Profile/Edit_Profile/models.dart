import 'dart:convert';
import 'dart:io';

class CustomerDetailsModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int accountId;
  final String password;
  final String dateOfBirth;
  final String phoneNumber;
  final String gender;
  final int age;
  final String anniversaryDate;
  final int country;
  final int state;
  final int city;
  final int area;
  final String zipCode;
  final String address;
  final String profileImage;
  final String nin;
  final String bvn;
  // final String employmentType;
  final String employer;
  final String jobTitle;
  final double netSalary;
  final double netWorth;
  final String industry;
  final String profession;
  final double monthlyIncome;
  final List<String> planOption;
  final NextOfKinDetailsModel? nextOfKinDetails;

  CustomerDetailsModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.accountId,
    required this.password,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.gender,
    required this.age,
    required this.anniversaryDate,
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.zipCode,
    required this.address,
    required this.profileImage,
    required this.nin,
    required this.bvn,
    // required this.employmentType,
    required this.employer,
    required this.jobTitle,
    required this.netSalary,
    required this.netWorth,
    required this.industry,
    required this.profession,
    required this.monthlyIncome,
    required this.planOption,
    this.nextOfKinDetails,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      accountId: json['accountId'] ?? 0,
      password: json['password'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? 0,
      anniversaryDate: json['anniversaryDate'] ?? '',
      country: json['country'] ?? 0,
      state: json['state'] ?? 0,
      city: json['city'] ?? 0,
      area: json['area'] ?? 0,
      zipCode: json['zipCode'] ?? '',
      address: json['address'] ?? '',
      profileImage: json['profileImage'] ?? '',
      nin: json['nin'] ?? '',
      bvn: json['bvn'] ?? '',
      // employmentType: json['employmentType'] ?? '',
      employer: json['employer'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      netSalary: (json['netSalary'] as num?)?.toDouble() ?? 0.0,
      netWorth: (json['netWorth'] as num?)?.toDouble() ?? 0.0,
      industry: json['industry'] ?? '',
      profession: json['profession'] ?? '',
      monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble() ?? 0.0,
      planOption: List<String>.from(json['planOption'] ?? []),
      nextOfKinDetails: json['NextOfKinDetails'] != null
          ? NextOfKinDetailsModel.fromJson(json['NextOfKinDetails'])
          : null,
    );
  }
}

class NextOfKinDetailsModel {
  final int id;
  final String name;
  final int age;
  final String relationship;
  final String phoneNumber;
  final String email;
  final String address;

  NextOfKinDetailsModel({
    required this.id,
    required this.name,
    required this.age,
    required this.relationship,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });

  factory NextOfKinDetailsModel.fromJson(Map<String, dynamic> json) {
    return NextOfKinDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      relationship: json['relationship'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
