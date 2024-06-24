
import 'package:flutter/material.dart';
import 'package:marewood_client/models/user.dart';

import '../../../api/users.dart';
import '../../../components/listPagination.dart';

class TabUser extends StatefulWidget {
  const TabUser({super.key});

  @override
  State<TabUser> createState() => TabUserState();
}


class TabUserState extends  State<TabUser>{

  final  _listRenderKey = GlobalKey<ListRender>();

  void refresh(){
    _listRenderKey.currentState?.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ListPagination(
      key: _listRenderKey,
      paginationReq: fetchUserPagination,
      itemBuilder: (context,item,refresh){
        var u = UseUser.fromJson(item);
        return Text(u.username);
      },
    );
  }

}