import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/2_application/core/page_config.dart';

class CreateTodoCollectionPageProvider extends StatelessWidget {
  const CreateTodoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateTodoCollectionPage();
  }
}

class CreateTodoCollectionPage extends StatefulWidget {
  const CreateTodoCollectionPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_collection',
    child: CreateTodoCollectionPage(),
  );

  @override
  State<CreateTodoCollectionPage> createState() =>
      _CreateTodoCollectionPageState();
}

class _CreateTodoCollectionPageState extends State<CreateTodoCollectionPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: GlobalKey(),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter atitle';
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'color'),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsedColorIndex = int.tryParse(value);
                  if (parsedColorIndex == null ||
                      parsedColorIndex < 0 ||
                      parsedColorIndex > TodoColor.predefinedColors.length) {
                    return ' only numbers between 0 and ${TodoColor.predefinedColors.length - 1} are allowed';
                  }
                }
                ;
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () {
              final isValide = _formKey.currentState?.validate();
              if(isValide == true){
                context.pop();
              }
            }, child: Text('save collection')),
          ],
        ),
      ),
    );
  }
}
