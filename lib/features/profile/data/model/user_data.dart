class UserData {
  final String displayName;
  final String email;
  final String? gender;
  final String? bloodType;
  final int weight;
  final int height;
  String? pictureUrl;

  UserData(
      {required this.displayName,
      required this.email,
      this.gender,
      required this.weight,
      required this.height,
      this.pictureUrl,
      this.bloodType});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      displayName: json['displayName'],
      email: json['email'],
      gender: json['gender'],
      weight: json['weight'],
      height: json['height'],
      pictureUrl: json['pictureUrl'],
      bloodType: json['bloodType'],
    );
  }
}
