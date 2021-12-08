/*
{
    "id": 13,
    "first_name": "Livvie",
    "last_name": "Beeres",
    "email": "lbeeresc@guardian.co.uk",
    "gender": "Female",
    "ip_address": "55.111.37.109",
    "address": "956 Beilfuss Lane",
    "phone": "+86 950 710 4859"
  }

*/
// To parse this JSON data, do
//
//     final Employee = EmployeeFromJson(jsonString);

import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.ipAddress,
    required this.address,
    required this.phone,
  });

  int? id;
  String firstName;
  String lastName;
  String email;
  String gender;
  String ipAddress;
  String address;
  String phone;

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        gender: json["gender"],
        ipAddress: json["ip_address"],
        address: json["address"],
        phone: json["phone"],
      );

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "gender": gender,
        "ip_address": ipAddress,
        "address": address,
        "phone": phone,
      };

  Employee copy({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? ipAddress,
    String? address,
    String? phone,
  }) =>
      Employee(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: lastName ?? this.email,
        gender: lastName ?? this.gender,
        ipAddress: lastName ?? this.ipAddress,
        address: lastName ?? this.address,
        phone: lastName ?? this.phone,
      );
}
