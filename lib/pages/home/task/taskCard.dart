import 'package:flutter/material.dart';
import 'package:marewood_client/models/task.dart';
import 'package:marewood_client/pages/home/task/status.dart';


class TaskCard extends StatelessWidget{
  const TaskCard({super.key, required this.task});

  final Task task;

  final bodyText =  const TextStyle(color:  Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
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
                        tooltip: "more action",
                        icon: const Icon(Icons.more_horiz,size: 20),
                        onPressed: () {

                        },
                      ),
                      IconButton(
                        tooltip: "terminal info",
                        icon: const Icon(Icons.terminal_outlined,size: 20),
                        onPressed: () {
                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(child: Container(
                                padding: const EdgeInsets.all(10.0),
                                color: Colors.black87,
                                child: Center(
                                  child: Text(task.terminalInfo,style: const TextStyle(color: Colors.white,fontSize: 12)),
                                ),
                              ));
                            },
                          );
                        },
                      ),
                      IconButton(
                        tooltip: "switch branches",
                        icon: const Icon(Icons.share,size: 20),
                        onPressed: () {},
                      ),

                      IconButton(
                        tooltip: "run task",
                        icon: const Icon(Icons.play_circle,size: 20),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
              
          ]),
      ),
    );
  }

}