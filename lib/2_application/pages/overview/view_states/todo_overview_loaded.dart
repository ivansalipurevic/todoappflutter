import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:go_router/go_router.dart';

class TodoOverviewLoaded extends StatelessWidget {
  const TodoOverviewLoaded({super.key, required this.collections});

  final List<TodoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final item = collections[index];
        final ColorScheme = Theme.of(context).colorScheme;

        return ListTile(
          tileColor: ColorScheme.surface,
          selectedTileColor: ColorScheme.surfaceVariant,
          iconColor: item.color.color,
          selectedColor: item.color.color,
          onTap: () {
            if(Breakpoints.small.isActive(context)){
              context.pushNamed(
                TodoDetailPage.pageConfig.name, params: {
                  'collectionId': item.id.value,
                }
              );
            }
          },
          leading: const Icon(Icons.circle),
          title: Text(item.title),
          
        );
      },
    );
  }
}
