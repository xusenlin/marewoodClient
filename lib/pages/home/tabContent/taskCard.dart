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
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(task.name),
                  Text('Status:${task.status.toString()}'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hash:${task.commitHash}'),
                    Text('BuildDir:${task.buildDir}'),
                    Text('RunTotal:${task.runTotal}'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Branch:${task.branch}'),
                  Text('BuildCmd:${task.buildCommand}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ID:${task.id.toString()}'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_circle),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.save_alt),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
              
          ]),
      ),
    );
  }

}