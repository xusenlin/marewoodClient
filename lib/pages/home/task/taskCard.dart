import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marewood_client/models/task.dart';
import 'package:marewood_client/pages/home/task/status.dart';
import 'package:marewood_client/pages/home/task/switchBranch.dart';
import 'package:marewood_client/stores/system.dart';
import 'package:marewood_client/stores/user.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../api/task.dart';
import '../../../components/iconWithText.dart';
import '../../../components/terminalOutDisplay.dart';
import '../../../routes.dart';
import '../../../stores/themeProvider.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.onChangeData});



  final Task task;
  final VoidCallback onChangeData;

  Future<void> onSwitchBranch(BuildContext context) async {
    try {
      var index = await switchBranch(task, context);
      if (index == null) return;
      onChangeData();
      if (!context.mounted) return;
      TDToast.showText("switch branch success", context: context);
    } catch (e) {
      if (!context.mounted) return;
      TDToast.showText(e.toString(), context: context);
    }
  }
  Future<void> onRunTask(BuildContext context) async {
    try {
      var msg = await runTask(task.id);
      onChangeData();
      if (!context.mounted) return;
      TDToast.showText(msg, context: context);

    } catch (e) {
      if (!context.mounted) return;
      TDToast.showText(e.toString(), context: context);
    }
  }
  Future<void> delTask(BuildContext context) async {
    try {
      var msg = await deleteTask(task.id);
      onChangeData();
      if (!context.mounted) return;
      TDToast.showText(msg, context: context);
    } catch (e) {
      if (!context.mounted) return;
      TDToast.showText(e.toString(), context: context);
    }
  }
  Future<void> download(BuildContext context, int type) async {
    try {
      var file = await downloadArchive(task, type);
      if (!context.mounted) return;
      TDToast.showText(file, context: context);
    } catch (e) {
      if (!context.mounted) return;
      TDToast.showText(e.toString(), context: context);
    }
  }

  void moreAction(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconWithText(
                          click: () {
                            Navigator.pushNamed(
                              context,
                              Routes.taskWebView,
                              arguments: task,
                            );
                          },
                          icon: Icons.web_asset,
                          text: 'Web Asset'),
                      IconWithText(
                          click: () async {
                            var address = await SystemStore.getAddress();
                            if (address == null) {
                              TDToast.showText('address is null', context: context);
                              return;
                            }
                            address += "/webs/${task.alias}";
                            Clipboard.setData(ClipboardData(text: address));
                            TDToast.showText("copy success", context: context);
                          },
                          icon: Icons.copy,
                          text: 'Copy Url'),
                      IconWithText(
                          click: () {
                            TDToast.showText('Under development', context: context);
                            //Navigator.pushNamed(context, Routes.taskEdit,arguments: task);
                          },
                          icon: Icons.design_services,
                          text: 'Edit Task'),
                      IconWithText(
                          click: () async => await delTask(context),
                          icon: Icons.delete,
                          text: 'Delete Task'),
                      IconWithText(
                          click: () async => await download(context, 1),
                          icon: Icons.save_alt,
                          text: 'Download Tar'),
                      IconWithText(
                          click: () async => await download(context, 2),
                          icon: Icons.save_alt,
                          text: 'Download Zip'),
                    ]),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("BuildDir："),
                        Text(task.buildDir,
                            style: TextStyle(color: themeProvider.themeColor)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("BuildCommand："),
                        Text(task.buildCommand,
                            style: TextStyle(color: themeProvider.themeColor)),
                      ],
                    ),
                  ]),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("RunTotal："),
                        Text(task.runTotal.toString(),
                            style: TextStyle(color: themeProvider.themeColor)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Alias："),
                        Text(task.alias,
                            style: TextStyle(color: themeProvider.themeColor)),
                      ],
                    ),
                  ]),
              const SizedBox(height: 20),
              const Text("Description："),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(task.description),
              )
            ]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    const bodyText = TextStyle(color: Colors.grey);
    var valText = TextStyle(color: themeProvider.themeColor);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 18),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('${task.tag}${task.name}',
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 3, 7, 18))),
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
                const Text('TaskBranch：', style: bodyText),
                Text(task.branch, style: valText),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('CommitHash：', style: bodyText),
              Text(task.commitHash, style: valText),
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
                    child: Text('#${task.id.toString()}',
                        style: TextStyle(color: themeProvider.themeColor)),
                  ),
                  if (task.private)
                    Icon(Icons.lock_outline, color: themeProvider.themeColor, size: 16),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: "more action",
                    icon: const Icon(Icons.more_horiz,
                        size: 20, color: Colors.grey),
                    onPressed: () => moreAction(context),
                  ),
                  IconButton(
                    tooltip: "terminal info",
                    icon: const Icon(Icons.terminal_outlined, size: 20),
                    onPressed: () => terminalOutDisplay(context,task.terminalInfo),
                  ),
                  IconButton(
                    tooltip: "switch branches",
                    icon: const Icon(Icons.share, size: 20),
                    onPressed: () async => await onSwitchBranch(context),
                  ),
                  IconButton(
                    tooltip: "run task",
                    icon: const Icon(Icons.play_circle, size: 20),
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
