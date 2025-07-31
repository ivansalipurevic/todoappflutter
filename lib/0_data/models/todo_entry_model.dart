import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_entry_model.g.dart';

@JsonSerializable()

class TodoEntryModel extends Equatable{
  final String description;
  final bool isDone;
  final String id;

  const TodoEntryModel({
    required this.id,
    required this.description,
    required this.isDone,
  });

  factory TodoEntryModel.fromJson(Map<String, dynamic> json) => _$TodoEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoEntryModelToJson(this);



  @override
  List<Object?> get props =>[
    id,
    isDone,
    description,
  ];
}