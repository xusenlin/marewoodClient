import 'package:flutter/material.dart';
import 'package:marewood_client/models/task.dart';
import 'package:marewood_client/pages/home/task/status.dart';
import 'package:marewood_client/pages/home/task/switchBranch.dart';
import 'package:provider/provider.dart';

import '../../../api/task.dart';
import '../../../components/iconWithText.dart';
import '../../../stores/themeProvider.dart';


class TaskCard extends StatelessWidget{
  const TaskCard({super.key, required this.task, required this.onChangeData});

  final Task task;
  final VoidCallback onChangeData;



  Future<void> onSwitchBranch(BuildContext context) async {
    try{
      var index = await switchBranch(task,context);
      if(index==null)return;
      onChangeData();
      if(!context.mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("switch branch success")
        ),
      );
    }catch(e){
      if(!context.mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(e.toString())
        ),
      );
    }
  }

  Future<void> onRunTask(BuildContext context) async {
    try{
      var msg = await runTask(task.id);
      onChangeData();
      if(!context.mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(msg)
        ),
      );
    }catch(e){
      if(!context.mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(e.toString())
        ),
      );
    }

  }

  Future<void> download(BuildContext context,int type) async {
    try{
      var file = await downloadArchive(task,type);
      if(!context.mounted)return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(file)
        ),
      );
    }catch(e){
      if(!context.mounted)return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(e.toString())
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    const bodyText =  TextStyle(color:  Colors.grey);
    var valText =  TextStyle(color:  themeProvider.themeColor);


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
              // const Divider(color: Color.fromARGB(255, 229, 231, 235)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('TaskBranch：',style: bodyText),
                    Text(task.branch,style: valText),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CommitHash：',style: bodyText),
                  Text(task.commitHash,style: valText),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text('#${task.id.toString()}',style:  TextStyle(color:  themeProvider.themeColor)),
                      ),
                      if(task.private)const Icon(Icons.lock_outline,color: Colors.green,size: 16),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        tooltip: "more action",
                        icon: const Icon(Icons.more_horiz,size: 20,color: Colors.grey),
                        onPressed: () {
                          showModalBottomSheet(
                            showDragHandle: true,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                color: Colors.white,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          IconWithText(
                                              click: (){},
                                              icon: Icons.web_asset,
                                              text: 'Web Asset'
                                          ),
                                          IconWithText(click: (){},icon: Icons.delete, text: 'Edit Task'),
                                          IconWithText(click: (){},icon: Icons.design_services, text: 'Delete Task'),
                                          IconWithText(click: () async => await download(context,1),icon: Icons.arrow_downward, text: 'Download Tar'),
                                          IconWithText(
                                              click: () async => await download(context,2),
                                              icon: Icons.save_alt,
                                              text: 'Download Zip'
                                          ),
                                        ]
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("BuildDir："),
                                              Text(task.buildDir,style:  TextStyle(color:  themeProvider.themeColor)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("BuildCommand："),
                                              Text(task.buildCommand,style:  TextStyle(color:  themeProvider.themeColor)),
                                            ],
                                          ),
                                        ]
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("RunTotal："),
                                              Text(task.runTotal.toString(),style:  TextStyle(color:  themeProvider.themeColor)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Alias："),
                                              Text(task.alias,style:  TextStyle(color:  themeProvider.themeColor)),
                                            ],
                                          ),
                                        ]
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ListTile(
                                    title: const Text("Description："),
                                    subtitle: Text(task.description),
                                  )
                                ])
                              );
                            },
                          );
                          // Navigator.pushNamed(context, Routes.login);
                        },
                      ),
                      IconButton(
                        tooltip: "terminal info",
                        icon: const Icon(Icons.terminal_outlined,size: 20),
                        onPressed: () {
                          showModalBottomSheet(
                            showDragHandle: true,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(16),
                                color: Colors.white,
                                child:Text(task.terminalInfo,style: const TextStyle(color: Colors.black87,fontSize: 12)),
                              ));
                            },
                          );
                        },
                      ),
                      IconButton(
                        tooltip: "switch branches",
                        icon: const Icon(Icons.share,size: 20),
                        onPressed: () async => await onSwitchBranch(context),
                      ),
                      IconButton(
                        tooltip: "run task",
                        icon: const Icon(Icons.play_circle,size: 20),
                        onPressed: () async => await onRunTask(context),
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