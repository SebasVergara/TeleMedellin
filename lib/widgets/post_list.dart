import 'package:flutter/material.dart';

import '../model/post.dart';
import '../network/api.dart';
import '../widgets/post_list_item.dart';

class PostsList extends StatefulWidget {
  int category = 0;

  PostsList({this.category = 0});

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
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
    _scrollController.addListener(() {
//      print(_scrollController.position.pixels);
      if (_scrollController.position.pixels <= 0) {
//        typeScroll = NeverScrollableScrollPhysics();
        typeScroll = ClampingScrollPhysics();
      } else {
//        typeScroll = NeverScrollableScrollPhysics();
        typeScroll = ClampingScrollPhysics();
      }
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
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
    return ListView.builder(
      itemBuilder: postTile,
      itemCount: posts.length + 1,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
//      physics: const NeverScrollableScrollPhysics(),
      physics: typeScroll,
      controller: _scrollController,
    );
  }

  Widget postTile(BuildContext context, int index) {
    if (index == posts.length) {
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
