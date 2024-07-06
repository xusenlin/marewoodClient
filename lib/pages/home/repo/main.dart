import 'package:flutter/material.dart';
import 'package:marewood_client/api/repository.dart';
import 'package:marewood_client/models/repository.dart';
import 'package:marewood_client/pages/home/repo/repoCard.dart';
import '../../../components/listPagination.dart';
import '../../../utils/sse.dart';


class TabRepositories extends StatefulWidget {
  const TabRepositories({super.key});

  @override
  State<TabRepositories> createState() => TabRepositoriesState();
}

class TabRepositoriesState extends State<TabRepositories> {

  late SseClient sseClient;
  final  _listRenderKey = GlobalKey<ListRender>();

  @override
  void initState() {
    subscribeRepoEvent();
    super.initState();
  }


  void refresh(){
    _listRenderKey.currentState?.refresh();
  }

  void subscribeRepoEvent() async {
    sseClient = SseClient('/v1/event/repository');
    sseClient.startSubscribe((data) {
      refresh();
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
      paginationReq: fetchRepoPagination,
      itemBuilder: (context,item,refresh){
        var repo = Repository.fromJson(item);
          return RepositoryCard(
              repository: repo,
              onChangeData: refresh
          );
      },
    );
  }
}
