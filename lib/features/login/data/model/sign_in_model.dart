//* The response when loged in
class SignInModel {
  final String token;
  final String name;
  final String email;
  final double? height;
  final double? weight;
  final String? gender;
  final String? pictureUrl;

  SignInModel({
    required this.token,
    required this.name,
    required this.email,
    this.height,
    this.weight,
    this.gender,
    this.pictureUrl,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      token: json['token'],
      name: json['displayName'],
      email: json['email'],
      height: json['height']?.toDouble(),
      weight: json['weight']?.toDouble(),
      gender: json['gender'],
      pictureUrl: json['pictureUrl'],
    );
  }
}
