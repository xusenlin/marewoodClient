import 'package:flutter/material.dart';
import '../../../utils/sse.dart';
import './taskCard.dart';
import '../../../api/task.dart';
import '../../../components/pagination.dart';
import '../../../models/task.dart';

class TabTask extends StatefulWidget {
  const TabTask({super.key});

  @override
  State<TabTask> createState() => TaskList();
}

class TaskList extends  State<TabTask>{

  late SseClient sseClient;

  List<Task> tasks = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;
  String name = "";
  String tags = "";


  @override
  void initState() {
    super.initState();
    fetchTasks();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {subscribeTaskEvent();}
    });
  }

  void refresh(){
    setState(() {
      currentPage=1;
      fetchTasks();
    });
  }

  Future<void> fetchTasks() async {
    setState(() {
      isLoading = true;
    });
    try{
      var pagination = await fetchTasksPagination(
        pageNum: currentPage,
        name: name,
        tags: tags,
      );
      setState(() {
        tasks = pagination.list.map((item) => Task.fromJson(item)).toList();
        totalPages = pagination.totalPage;
        isLoading = false;
      });

    }catch(e){
      setState(() {
        tasks = [];
        totalPages = 1;
        isLoading = false;
      });
    }
  }

  void _previousPage() {
    setState(() {
      currentPage--;
      fetchTasks();
    });
  }
  void _nextPage() {
    setState(() {
      currentPage++;
      fetchTasks();
    });
  }


  void subscribeTaskEvent(){
    sseClient = SseClient('/v1/event/task');
    sseClient.stream.listen((data) {
      // const eventTypeEditOk = "editOk"
      // const eventTypeDestroyOk = "destroyOk"
      // const eventTaskTypeRunOk = "runOk"
      // const eventTaskTypeBuildOk = "buildOk"
      // const eventTaskTypeBuildFail = "buildFail"
      // if(data=="buildOk"){
      //   fetchTasks();
      // }
      fetchTasks();
    });
  }

  @override
  void dispose() {
    sseClient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ?
    const Center(child: CircularProgressIndicator()) :
    ListView.builder(
      itemCount: tasks.length+1,
      itemBuilder: (context, index) {
        if (index == tasks.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Pagination(
                currentPage: currentPage,
                totalPages: totalPages,
                onPreviousPage: _previousPage,
                onNextPage: _nextPage,
              ),
            ),
          );
        }
        return TaskCard(task: tasks[index],onChangeData: fetchTasks,);
      },
    );
  }
}