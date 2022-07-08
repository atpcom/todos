import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/todo_list.dart';
import './widgets/action_bar.dart';
import './widgets/add_todo.dart';
import './widgets/description.dart';
import './widgets/todo_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<TodoList>(
      create: (_) => TodoList(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Todos')),
        body: Column(
          children: const [
            AddTodo(),
            ActionBar(),
            Description(),
            TodoListView()
          ],
        ),
      ),
    );
  }
}
