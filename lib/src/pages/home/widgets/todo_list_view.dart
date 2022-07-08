import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../models/todo_list.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);
    return Observer(
      builder: (_) {
        return Flexible(
          child: ListView.builder(
            itemCount: list.visibleTodos.length,
            itemBuilder: (_, index) {
              final todo = list.visibleTodos[index];
              return Observer(
                builder: (_) {
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: todo.done,
                    onChanged: (flag) => todo.done = flag!,
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            todo.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => list.removeTodo(todo),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
