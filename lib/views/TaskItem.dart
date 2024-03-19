import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ufoad_flutter/models/TaskModel.dart';


class TaskListItem extends StatelessWidget {
  final Task task;
  final Function onDelete;

  const TaskListItem({super.key, required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: ListTile(
            title: Text(task.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete(),
            ),
          ),
        ),
      ],
    );
  }
}