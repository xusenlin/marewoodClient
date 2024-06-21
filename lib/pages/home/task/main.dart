import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../stores/userProvider.dart';
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
    fetchTasks();
    // Future.delayed(const Duration(seconds: 2), () {
    //   if (mounted) {subscribeTaskEvent();}
    // });
    subscribeTaskEvent();
    super.initState();
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
      if(!mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(e.toString())
        ),
      );
      if(e.toString().contains("token is expired")){
        var userProvider = Provider.of<UserProvider>(context,listen: false);
        userProvider.removeUser();
      }
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
      setState(() {
        currentPage=1;
        fetchTasks();
      });
    },onError: (e){
      if(!mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString())
        ),
      );
    });
  }

  @override
  void dispose() {
    sseClient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      if(tasks.isNotEmpty)
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
          return TaskCard(task: tasks[index],onChangeData: fetchTasks);
        },
      ),
      if (isLoading)
        const Positioned.fill(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
    ]);
  }
}