import 'dart:convert';

List<chatbot> newFromJson(String str) => List<chatbot>.from(json.decode(str).map((x) => chatbot.fromJson(x)));

String newToJson(List<chatbot> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class chatbot {
  String? recipientId;
  String? text;
  double? confidence;

  chatbot({this.recipientId, this.text, this.confidence});

  chatbot.fromJson(Map<String, dynamic> json) {
    recipientId = json['recipient_id'];
    text = json['text'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipient_id'] = this.recipientId;
    data['text'] = this.text;
    data['confidence'] = this.confidence;
    return data;
  }
}
