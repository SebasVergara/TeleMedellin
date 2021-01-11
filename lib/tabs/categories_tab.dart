import 'package:flutter/material.dart';

import '../model/post.dart';
import '../network/api.dart';
import '../pages/single_category.dart';

class CategoriesTab extends StatefulWidget {
  @override
  _CategoriesTabState createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  List<PostCategory> categories = new List<PostCategory>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                sliver: categoryTile(context),
              )
//              categoryTile(context)
//              Padding(
//                padding: EdgeInsets.only(left: 8.0, right: 8.0),
//                child: ,
//              ),
            ],
//      itemBuilder: categoryTile,
//      itemCount: categories.length,
//      scrollDirection: Axis.vertical,
//      shrinkWrap: true,
//      physics: ClampingScrollPhysics(),
          );
  }

  void _getCategoriesList() {
    WpApi.getCategoriesList().then((_categories) {
      if (mounted) {
        setState(() {
          isLoading = false;
          categories.addAll(_categories);
        });
      }
    });
  }

  Widget categoryTile(BuildContext context) {
//    PostCategory category = categories[index];

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        childAspectRatio: 2.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          PostCategory category = categories[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleCategory(category))
                );
              },
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).accentColor,
                  //              boxShadow: [
                  //                BoxShadow(color: Colors.green, spreadRadius: 3),
                  //              ],
                ),
                alignment: Alignment.center,
                //            color: Theme.of(context).accentColor,
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display2,
                ),
              ));
        },
        childCount: categories.length,
      ),
    );

//      ListTile(
//      title: Text(category.name),
//      onTap: () {
//        Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCategory(category)));
//      },
//    );
  }
}
