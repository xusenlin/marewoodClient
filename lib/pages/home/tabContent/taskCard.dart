import 'package:flutter/material.dart';
import 'package:marewood_client/models/task.dart';

class Status extends StatelessWidget{
  const Status({super.key, required this.status});

  final int status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 0:
        return const Icon(Icons.panorama_fish_eye_outlined,color: Colors.grey);
      case 1:
        return const SizedBox(width: 18.0, height: 18.0, child: CircularProgressIndicator(strokeWidth: 2),);
      case 2:
        return const Icon(Icons.remove_circle_outline,color: Colors.redAccent);
      case 3:
        return const Icon(Icons.check_circle_outline,color: Colors.green);
      default:
        return const Icon(Icons.panorama_fish_eye_outlined,color: Colors.grey);
    }
  }

}



class TaskCard extends StatelessWidget{
  const TaskCard({super.key, required this.task});

  final Task task;

  final bodyText =  const TextStyle(color:  Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 9,horizontal:
      18),
      child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child:Text(
                          '${task.tag}${task.name}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Color.fromARGB(255, 3, 7, 18))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Status(status: task.status),
                  ),
                  // Text('Status:${task.status.toString()}'),
                ],
              ),
              const Divider(color: Color.fromARGB(255, 229, 231, 235)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Branch:${task.branch}',style: bodyText),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hash:${task.commitHash}',style: bodyText),
                  Text('RunTotal:${task.runTotal}',style: bodyText),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text('#${task.id.toString()}',style: const TextStyle(color:  Colors.grey)),
                      ),
                      if(task.private)const Icon(Icons.lock_outline,color: Colors.green,size: 16),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_circle),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.save_alt),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
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