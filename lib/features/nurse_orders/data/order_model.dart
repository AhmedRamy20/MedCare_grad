class Order {
  final int id;
  final String bookingDate;
  final String nurseName;
  final String userName;
  String status;
  final String location;

  Order({
    required this.id,
    required this.bookingDate,
    required this.nurseName,
    required this.userName,
    this.status = 'pending',
    required this.location,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      bookingDate: json['bookingDate'],
      nurseName: json['nurseName'],
      userName: json['userName'],
      // status: json['status'],
      status: json['status'] ?? 'pending',
      location: json['location'],
    );
  }
}
