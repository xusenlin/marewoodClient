import 'package:flutter/material.dart';
import 'package:marewood_client/models/task.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';


class TaskEdit extends StatefulWidget {
  final Task? task;

  const TaskEdit({super.key, this.task});
  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {


  late TextEditingController nameController = TextEditingController(text: widget.task?.name);

  @override
  void initState() {
    super.initState();
    // nameController = TextEditingController(text: widget.task?.name);
  }


  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task==null ? "New Task":widget.task!.name),
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
                controller: nameController,
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
