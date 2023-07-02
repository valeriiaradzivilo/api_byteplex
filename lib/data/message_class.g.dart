// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageClass _$MessageClassFromJson(Map<String, dynamic> json) => MessageClass(
      name: json['name'] as String,
      email: json['email'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$MessageClassToJson(MessageClass instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'message': instance.message,
    };
