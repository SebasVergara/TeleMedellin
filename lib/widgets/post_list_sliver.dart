import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../model/post.dart';
import '../network/api.dart';
import '../widgets/post_list_item.dart';

class PostsListSliver extends StatefulWidget {
  int category = 0;
  ScrollController scrollControllers;
  PostsListSliver({this.category = 0, this.scrollControllers });

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsListSliver> {
  final rnd = math.Random();
  Color getRandomColor() => Color(rnd.nextInt(0xffffffff));

  List<PostEntity> posts = new List<PostEntity>();

  int page = 0;
  var typeScroll;
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

  void getData() {
    if (!isLoading) {
      setState(() {
        page++;
        isLoading = true;
      });

      WpApi.getPostsList(category: widget.category, page: page).then((_posts) {
        setState(() {
          isLoading = false;
          posts.addAll(_posts);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
//    print('init');
//    print(widget.scrollControllers);
    widget.scrollControllers.addListener(() {
//      print('scroll');
//      print(widget.scrollControllers.position.pixels);
//      print(widget.scrollControllers.position.maxScrollExtent);
//      if (_scrollController.position.pixels <= 0) {
//        typeScroll = NeverScrollableScrollPhysics();
//      } else {
//        typeScroll = NeverScrollableScrollPhysics();
////        typeScroll = ClampingScrollPhysics();
//      }
      if (widget.scrollControllers.position.pixels ==
          widget.scrollControllers.position.maxScrollExtent - 0) {
        getData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return postTile(context, index);
        },
        childCount: posts.length,
      ),
    );
  }

  Widget postTile(BuildContext context, int index) {
//    print(index);
//    print(posts.length);
//    print(posts);
//    if (index == posts.length) {
    return PostListItem(posts[index]);
    if (index == posts.length - 1) {
      return _buildProgressIndicator();
    } else {
      return PostListItem(posts[index]);
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Visibility(
          visible: isLoading,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
