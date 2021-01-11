import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../config.dart';
import '../model/post.dart';
import '../pages/single_category.dart';
import '../widgets/featured_category_list.dart';
import '../widgets/post_list_sliver.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final rnd = math.Random();
  ScrollController _scrollControllers = new ScrollController();

  Color getRandomColor() => Color(rnd.nextInt(0xffffffff));

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollControllers,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            ListHeading(FEATURED_CATEGORY_TITLE, FEATURED_CATEGORY_ID),
            Container(
              height: 250.0,
              child: FeaturedCategoryList(),
            ),
          ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 20.0,),
            ListHeadingText('Últimas noticias'),
          ],
          ),
        ),
        PostsListSliver(category: 0, scrollControllers: _scrollControllers),
        SliverList(delegate: SliverChildListDelegate([
          _buildProgressIndicator(),
        ]))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Visibility(
//          visible: isLoading,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ListHeading extends StatelessWidget {
  final String title;
  final int categoryId;

  ListHeading(this.title, this.categoryId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.display1,
          ),
          GestureDetector(
            onTap: () {
              PostCategory category = PostCategory(name: title, id: categoryId);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCategory(category)));
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Theme.of(context).textSelectionColor),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Text('Ver todos'),
            ),
          )
        ],
      ),
    );
  }
}
class ListHeadingText extends StatelessWidget {
  final String title;

  ListHeadingText(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }
}