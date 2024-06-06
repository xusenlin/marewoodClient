import 'package:flutter/material.dart';
import 'package:marewood_client/models/task.dart';

class TaskCard extends StatelessWidget{
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 9,horizontal:
      18),
      child: Row(
          children: [
            Text(task.name),
            Text(task.id.toString())
          ]
      ),
    );
  }

}