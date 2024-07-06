import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/listPagination.dart';
import '../../../stores/userProvider.dart';
import '../../../utils/sse.dart';
import './taskCard.dart';
import '../../../api/task.dart';
import '../../../components/pagination.dart';
import '../../../models/task.dart';

class TabTask extends StatefulWidget {
  const TabTask({super.key});
  @override
  State<TabTask> createState() => TaskListState();
}

class TaskListState extends  State<TabTask>{

  late SseClient sseClient;
  final  _listRenderKey = GlobalKey<ListRender>();


  @override
  void initState() {

    subscribeTaskEvent();
    super.initState();
  }

  void refresh(){
    _listRenderKey.currentState?.refresh();
  }



  void subscribeTaskEvent() {
    sseClient = SseClient('/v1/event/task');

    sseClient.startSubscribe((data) {
      // const eventTypeEditOk = "editOk"
      // const eventTypeDestroyOk = "destroyOk"
      // const eventTaskTypeRunOk = "runOk"
      // const eventTaskTypeBuildOk = "buildOk"
      // const eventTaskTypeBuildFail = "buildFail"
      // if(data=="buildOk"){
      //   fetchTasks();
      // }
      print(data);
      refresh();
    })
        .then((r){
    })
        .catchError((err){
      print(err);
    });

  }

  @override
  void dispose() {
    sseClient.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListPagination(
      key: _listRenderKey,
      paginationReq: fetchTasksPagination,
      itemBuilder: (context,item,refresh){
        var repo = Task.fromJson(item);
        return TaskCard(
            task: repo,
            onChangeData: refresh
        );
      },
    );
  }
}