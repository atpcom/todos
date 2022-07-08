import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/todo_list.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);
    final textController = TextEditingController(text: '');
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
          labelText: 'Add a Todo', contentPadding: EdgeInsets.all(8)),
      controller: textController,
      textInputAction: TextInputAction.done,
      onSubmitted: (String value) {
        list.addTodo(value);
        textController.clear();
      },
    );
  }
}
