import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/model/blogModel.dart';
import 'package:africoders_mobile/repo/blogRepo.dart';
import 'package:africoders_mobile/screens/blog/blog_list.dart';
import 'package:africoders_mobile/screens/blog/create_blog.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      backgroundColor: mainBgColor,
      appBar: buildAppBar(context),
      body: FutureBuilder<List<Blog>>(
        future: fetchBlogWithNoComments(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? BlogList(blogs: snapshot.data)
              : Center(
                  child: AfricodersLoader(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Color(0xFF547A7D),
        ),
        backgroundColor: Color(0xFF9CE0AD),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new CreateBlog();
          }));
        },
      ),
    );
  }
}
