import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart'; // Import CollectionId

class TodoCollection {
  final CollectionId id;  // Promenjeno sa EntryId na CollectionId
  final String title;
  final TodoColor color;

  TodoCollection({
    required this.id,
    required this.title,
    required this.color,
  });

  TodoCollection copyWith({
    String? title,
    TodoColor? color,
  }) {
    return TodoCollection(
      id: id,
      title: title ?? this.title,
      color: color ?? this.color,
    );
  }

  factory TodoCollection.empty() {
    return TodoCollection(
      id: CollectionId(''), 
      title: '',
      color: TodoColor(colorIndex: 0),
    );
  }
}
