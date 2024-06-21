import 'package:flutter/material.dart';
import 'package:marewood_client/components/pagination.dart';
import 'package:provider/provider.dart';

import '../models/pagination.dart';
import '../stores/userProvider.dart';

class ListPagination extends StatefulWidget {
  final Map<String,dynamic> ? parameter;
  final Future<PaginationData> Function({ int pageNum,int pageSize,Map<String,dynamic> ? parameter}) paginationReq;
  final Widget Function({ Map<String,dynamic> item,VoidCallback refresh }) itemBuilder;

  const ListPagination({super.key, required this.itemBuilder,  required this.paginationReq, this.parameter});

  @override
  State<ListPagination> createState() => _List();
}

class _List extends State<ListPagination> {

  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;
  late List<Map<String,dynamic>> items;

  @override
  void initState() {
    super.initState();
  }
  void refresh(){
    setState(() {
      currentPage=1;
      fetchItems();
    });
  }

  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
    });
    try{
      var pagination = await widget.paginationReq(
        pageNum: currentPage,
        parameter: widget.parameter
      );
      setState(() {
        items = pagination.list;
        totalPages = pagination.totalPage;
        isLoading = false;
      });
    }catch(e){
      setState(() {
        items = [];
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
      fetchItems();
    });
  }
  void _nextPage() {
    setState(() {
      currentPage++;
      fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        itemCount: items.length+1,
        itemBuilder: (context, index) {
          if (index == items.length) {
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
          return widget.itemBuilder(item:items[index],refresh: refresh);
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