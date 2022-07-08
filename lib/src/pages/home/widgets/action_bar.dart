import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../models/todo_list.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);
    return Column(
      children: <Widget>[
        Observer(
          builder: (_) {
            final selections = VisibilityFilter.values
                .map((f) => f == list.filter)
                .toList(growable: false);
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(8),
                    onPressed: (index) {
                      list.filter = VisibilityFilter.values[index];
                    },
                    isSelected: selections,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text('All'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text('Pending'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text('Completed'),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        Observer(
          builder: (_) => ButtonBar(
            children: <Widget>[
              ElevatedButton(
                onPressed:
                    list.canRemoveAllCompleted ? list.removeCompleted : null,
                child: const Text('Remove Completed'),
              ),
              ElevatedButton(
                onPressed:
                    list.canMarkAllCompleted ? list.markAllAsCompleted : null,
                child: const Text('Mark All Completed'),
              )
            ],
          ),
        )
      ],
    );
  }
}
