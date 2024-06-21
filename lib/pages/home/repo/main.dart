import 'package:flutter/material.dart';
import 'package:marewood_client/api/repository.dart';
import 'package:marewood_client/models/repository.dart';
import 'package:provider/provider.dart';

import '../../../components/pagination.dart';
import '../../../stores/userProvider.dart';
import '../../../utils/sse.dart';


class TabRepositories extends StatefulWidget {
  const TabRepositories({super.key});

  @override
  State<TabRepositories> createState() => TabRepositoriesState();
}

class TabRepositoriesState extends State<TabRepositories> {

  late SseClient sseClient;
  List<Repository> repositories = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;

  @override
  void initState() {
    fetchRepositories();
    subscribeRepoEvent();
    super.initState();
  }


  void refresh(){
    setState(() {
      currentPage=1;
      fetchRepositories();
    });
  }

  Future<void> fetchRepositories() async {
    setState(() {
      isLoading = true;
    });
    try{
      var pagination = await fetchRepoPagination(
        pageNum: currentPage,
        // name: name,
        // tags: tags,
      );
      setState(() {
        repositories = pagination.list.map((item) => Repository.fromJson(item)).toList();
        totalPages = pagination.totalPage;
        isLoading = false;
      });
    }catch(e){
      setState(() {
        repositories = [];
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
      fetchRepositories();
    });
  }
  void _nextPage() {
    setState(() {
      currentPage++;
      fetchRepositories();
    });
  }

  void subscribeRepoEvent(){
    sseClient = SseClient('/v1/event/repository');
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
        fetchRepositories();
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
      if(repositories.isNotEmpty)
      ListView.builder(
        itemCount: repositories.length+1,
        itemBuilder: (context, index) {
          if (index == repositories.length) {
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
          return Text("sad");
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
