// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoEntryModel _$TodoEntryModelFromJson(Map<String, dynamic> json) =>
    TodoEntryModel(
      id: json['id'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$TodoEntryModelToJson(TodoEntryModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'isDone': instance.isDone,
      'id': instance.id,
    };
