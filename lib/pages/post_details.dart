import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_share/flutter_share.dart';

import '../model/post.dart';
import '../widgets/helpers.dart';
import '../widgets/post_card.dart';

class PostDetails extends StatelessWidget {
  PostEntity post;

  PostDetails(this.post);

  @override
  Widget build(BuildContext context) {
//    post.isDetailCard = true;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          Size size = MediaQuery.of(context).size;
          return <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share_outlined),
                  tooltip: 'Open shopping cart',
                  onPressed: () {
                    _share(post.title, post.link);
                  },
                ),
              ],
              floating: true,
              pinned: true,
              expandedHeight: 300.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Hero(
                      tag: post.image,
                      child: CachedImage(
                        post.image,
                        width: size.width,
                        height: size.height,
                      ),
                    ),
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment(0.0, -0.65),
                            colors: [Colors.deepOrangeAccent, Colors.transparent],
                          ),
                        ),
                      ),
                    ),
//                    Positioned(
//                      bottom: 0,
//                      child: Author(post: post),
//                    ),
                    Positioned(
                      bottom: 35.0,
                      child: Container(
                          width: size.width,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  post.title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CategoryPill(post: post),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: DatePill(post: post),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child:
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Html(
              data: post.content,
              style: {
                "body": Style(
                  textAlign: TextAlign.justify,
                ),
              },
            ),

          ),
        ),
      ),
    );
  }
  Future<void> _share(String name, String url) async {
    await FlutterShare.share(
      title: name,
      text: name,
      linkUrl: url,
    );
  }
}
