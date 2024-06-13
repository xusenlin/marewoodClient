import 'package:flutter/material.dart';
import 'package:marewood_client/models/task.dart';

import '../../../api/repo.dart';
import '../../../api/task.dart';

Future<int?> switchBranch(Task task,BuildContext context) async {
  try{
    List<dynamic> branch = await fetchRepositoryBranch(task.repositoryId);

    int? i = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            title: const Text('switch branch'),
            children: List.generate(branch.length, (index) {
              return SimpleDialogOption(
                onPressed:branch[index]==task.branch ? null: () {
                  Navigator.pop(context, index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                      branch[index],
                      style: branch[index]==task.branch ? const TextStyle(fontSize: 18,color: Colors.grey):const TextStyle(fontSize: 18)),
                ),
              );
            })
        );
      });
    if (i==null)return null;
    await updateTaskBranch(task.id,branch[i]);
    return i;
  }catch(e){
    if(!context.mounted) return null;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString() )
      ),
    );
    return null;
  }
}