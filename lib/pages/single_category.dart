import 'package:flutter/material.dart';

import '../model/post.dart';
import '../widgets/post_list.dart';

class SingleCategory extends StatelessWidget {
  PostCategory category;

  SingleCategory(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: PostsList(category: category.id),
    );
  }
}
