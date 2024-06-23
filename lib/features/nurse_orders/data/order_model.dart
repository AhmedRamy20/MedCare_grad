class Order {
  final int id;
  final String bookingDate;
  final String? nurseName;
  final String userName;
  String status;
  final String location;
  final List<TestDto> testDtos;

  Order({
    required this.id,
    required this.bookingDate,
    this.nurseName,
    required this.userName,
    this.status = 'pending',
    required this.location,
    required this.testDtos,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var testDtosJson = json['testDtos'] as List;
    List<TestDto> testDtosList =
        testDtosJson.map((test) => TestDto.fromJson(test)).toList();

    return Order(
      id: json['id'],
      bookingDate: json['bookingDate'],
      nurseName: json['nurseName'],
      userName: json['userName'],
      // status: json['status'],
      status: json['status'] ?? 'pending',
      location: json['location'],
      testDtos: testDtosList,
    );
  }

  String getTestNames() {
    return testDtos.map((test) => test.name).join(', ');
  }
}

class TestDto {
  final String name;

  TestDto({
    required this.name,
  });

  factory TestDto.fromJson(Map<String, dynamic> json) {
    return TestDto(
      name: json['name'],
    );
  }
}
