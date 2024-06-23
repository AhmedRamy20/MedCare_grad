import 'package:equatable/equatable.dart';

class Lab extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String pictureUrl;
  final String location;

  Lab({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.pictureUrl,
    required this.location,
  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      pictureUrl: json['pictureUrl'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'pictureUrl': pictureUrl,
      'location': location,
    };
  }

  @override
  List<Object?> get props => [id, name, email, phone, pictureUrl, location];
}

class LabTestModel extends Equatable {
  final int id;
  final String name;
  final String? description;
  final double price;
  final Lab lab;
  final String? imageUrl;
  DateTime? bookingTime;
  //*
  int quantity;

  LabTestModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.lab,
    this.imageUrl,
    this.quantity = 1,
    this.bookingTime,
  });

  factory LabTestModel.fromJson(Map<String, dynamic> json) {
    return LabTestModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: json['price'].toDouble(),
      lab: Lab.fromJson(json['lab']),
      imageUrl: json['imageUrl'] ?? '',
      quantity: json['quantity'] ?? 1, //!pref
      bookingTime: json['bookingTime'] != null
          ? DateTime.parse(json['bookingTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'lab': lab.toJson(),
      'imageUrl': imageUrl,
      'quantity': quantity,
      'bookingTime': bookingTime?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props =>
      [id, name, description, price, lab, imageUrl, quantity, bookingTime];
}
