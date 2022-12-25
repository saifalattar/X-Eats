// import 'package:flutter/material.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
// RefreshController _refreshController = RefreshController(initialRefresh: false);

// void _onRefresh() async {
//   // monitor network fetch
//   await Future.delayed(Duration(milliseconds: 1000));
//   // if failed,use refreshFailed()
//   _refreshController.refreshCompleted();
// }

// void _onLoading() async {
//   // monitor network fetch
//   await Future.delayed(Duration(milliseconds: 1000));
//   // if failed,use loadFailed(),if no data return,use LoadNodata()
//   items.add((items.length + 1).toString());
//   if (mounted) setState(() {});
//   _refreshController.loadComplete();
// }


// st
