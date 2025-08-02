import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';

class TodoOverviewLoaded extends StatelessWidget {
  const TodoOverviewLoaded({super.key, required this.collections});

  final List<TodoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: collections.length,
          itemBuilder: (context, index) {
            final item = collections[index];
            final colorScheme = Theme.of(context).colorScheme;

            return BlocBuilder<NavigationTodoCubit, NavigationTodoCubitState>(
              buildWhen: (previous, current) =>
                  previous.selectedCollectionId != current.selectedCollectionId,
              builder: (context, state) {
                debugPrint('build item ${item.id.value}');
                return ListTile(
                  tileColor: colorScheme.surface,
                  selectedTileColor: colorScheme.surfaceVariant,
                  iconColor: item.color.color,
                  selectedColor: item.color.color,
                  selected: state.selectedCollectionId?.value == item.id.value,
                  onTap: () {
                    context
                        .read<NavigationTodoCubit>()
                        .selectedTodoCollectionChanged(item.id);

                    if (Breakpoints.small.isActive(context)) {
                      context.pushNamed(
                        TodoDetailPage.pageConfig.name,
                        pathParameters: {'collectionId': item.id.value},
                      );
                    }
                  },
                  leading: const Icon(Icons.circle),
                  title: Text(item.title),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              key: const Key('create-todo-collection'),
              heroTag: 'create-todo-collection',
              onPressed: () {
                context
                    .pushNamed(CreateTodoCollectionPage.pageConfig.name)
                    .then((value) => null);
              },
              child: Icon(CreateTodoCollectionPage.pageConfig.icon),
            ),
          ),
        ),
      ],
    );
  }
}
