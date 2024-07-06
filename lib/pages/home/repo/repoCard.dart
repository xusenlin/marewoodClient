import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marewood_client/pages/home/repo/status.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../api/repository.dart';
import '../../../components/iconWithText.dart';
import '../../../components/terminalOutDisplay.dart';
import '../../../models/repository.dart';
import '../../../stores/themeProvider.dart';

class RepositoryCard extends StatelessWidget {
  const RepositoryCard({super.key, required this.repository, required this.onChangeData});

  final Repository repository;
  final VoidCallback onChangeData;

  Future<void> delRepo(BuildContext context) async {
    try {
      var msg = await deleteRepo(repository.id);
      onChangeData();
      if (!context.mounted) return;
      TDToast.showText(msg, context: context);
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
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconWithText(
                            click: () async {
                              Clipboard.setData(ClipboardData(text: repository.url));
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
                            text: 'Edit Repo'),
                        IconWithText(
                            click: () async => await delRepo(context),
                            icon: Icons.delete,
                            text: 'Delete Repo'),
                      ]),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("TaskStatus："),
                      Text(repository.status == 1 ? "Busy":"Leisured",
                          style: TextStyle(color: themeProvider.themeColor)),
                    ]),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("RepoUrl："),
                      const SizedBox(width: 80),
                      Flexible(
                        child: Text(
                          repository.url,
                          style: TextStyle(color: themeProvider.themeColor),
                        ),
                      ),
                    ]),
                const SizedBox(height: 20),
                const Text("Description："),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(repository.description),
                )
            ])
        );
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
                child: Text(repository.name,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 3, 7, 18))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Status(status: repository.status),
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
                const Text('DefaultBranch：', style: bodyText),
                Text(repository.defaultBranch, style: valText),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('DependTools：', style: bodyText),
              Text(repository.dependTools.toUpperCase(), style: valText),
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
                    child: Text('#${repository.id.toString()}',
                        style: TextStyle(color: themeProvider.themeColor)),
                  ),
                  if (repository.userName != ""&&repository.password != "")
                    Icon(Icons.lock_outline, color: themeProvider.themeColor, size: 16),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: "more action",
                    icon: const Icon(
                        Icons.more_horiz,
                        size: 20, color: Colors.grey
                    ),
                    onPressed: () {
                      moreAction(context);
                    },
                  ),
                  IconButton(
                    tooltip: "terminal info",
                    icon: const Icon(Icons.terminal_outlined, size: 20),
                    onPressed: () => terminalOutDisplay(context,repository.terminalInfo),
                  ),
                  //
                  IconButton(
                    tooltip: "git checkout .",
                    icon: const Icon(Icons.replay, size: 20),
                    onPressed: () async {
                      var msg = await execGitCheckoutDot(repository.id);
                      if(!context.mounted)return;
                      TDToast.showText(msg, context: context);
                    },
                  ),
                  IconButton(
                    tooltip: "git pull",
                    icon: const Icon(Icons.import_export, size: 20),
                    onPressed: () async {
                      var msg = await execGitPull(repository.id);
                      if(!context.mounted)return;
                      TDToast.showText(msg, context: context);
                    },
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
