import 'package:flutter/material.dart';
import 'package:marewood_client/models/task.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TaskEdit extends StatelessWidget {
  TaskEdit({super.key, this.task});

  final Task ? task;

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(task==null ? "New Task":task!.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TDInput(
                leftLabel: 'Name',
                contentAlignment:TextAlign.end,
                required: true,
                // controller: ,
                backgroundColor: Colors.white,
                hintText: 'Please enter name',
                onChanged: (text) {
                },
                onClearTap: () {

                },
              ),
              SizedBox(height: 10),
              TDInput(
                contentAlignment:TextAlign.end,
                leftLabel: 'Alias',
                required: true,
                // controller: ,
                backgroundColor: Colors.white,
                hintText: 'Please enter alias',
                onChanged: (text) {
                },
                onClearTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
