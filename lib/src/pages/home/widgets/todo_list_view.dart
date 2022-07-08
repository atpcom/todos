import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';

import '../../../models/todo_list.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);
    final format = DateFormat.yMd(Intl.systemLocale);
    final controller = TextEditingController();
    return Observer(
      builder: (_) {
        return Flexible(
          child: ReorderableListView.builder(
            onReorder: list.reorder,
            buildDefaultDragHandles: true,
            itemCount: list.visibleTodos.length,
            itemBuilder: (_, index) {
              final todo = list.visibleTodos[index];
              return Dismissible(
                key: Key(index.toString()),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want edit?'),
                              content: TextField(
                                autofocus: true,
                                controller: controller..text = todo.description,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (data) {
                                  if (data.isNotEmpty) {
                                    todo.description = data;
                                    controller.clear();
                                    context.router.pop(false);
                                  }
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => context.router.pop(false),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                  } else {
                    await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () => context.router.pop(false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.router.pop(true);
                                    list.removeTodo(todo);
                                  },
                                  child: const Text('Ok'),
                                )
                              ],
                            );
                          },
                        ) ??
                        false;
                  }
                },
                child: Observer(
                  builder: (_) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: todo.done,
                      onChanged: (flag) => todo.done = flag!,
                      title: Text(
                        todo.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(format.format(todo.create)),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
