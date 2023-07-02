import 'package:json_annotation/json_annotation.dart';

part 'message_class.g.dart';

@JsonSerializable()
class MessageClass {
  final String name;
  final String email;
  final String message;

  MessageClass({required this.name, required this.email, required this.message});
  factory MessageClass.fromJson(Map<String, dynamic> json) => _$MessageClassFromJson(json);

  Map<String, dynamic> toJson() => _$MessageClassToJson(this);
}
