import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_collection_model.g.dart';

@JsonSerializable()

class TodoCollectionModel extends Equatable{
  final int colorIndex;
  final String title;
  final String id;

  const TodoCollectionModel({
    required this.id,
    required this.title,
    required this.colorIndex,
  });

  factory TodoCollectionModel.fromJson(Map<String, dynamic> json) => _$TodoCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoCollectionModelToJson(this);



  @override
  List<Object?> get props =>[
    id,
    title,
    colorIndex,
  ];
}