import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class TodoCollection {
  final CollectionId id;
  final String title;
  final TodoColor color;

  TodoCollection({required this.id, required this.title, required this.color});

  factory TodoCollection.empty(){
    return TodoCollection(
      id: CollectionId(),
      title: '',
      color: TodoColor(
        colorIndex: 0,
      ),

    );
  }
}