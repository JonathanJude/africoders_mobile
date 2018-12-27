import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/model/blogModel.dart';
import 'package:africoders_mobile/screens/blog/blog_article.dart';
import 'package:flutter/material.dart';

class BlogList extends StatelessWidget {
  final List<Blog> blogs;

  BlogList({this.blogs});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          allBlogsTextHeader(),
          Column(
            children: blogs.map(
              (blog) {
                var blogContent = parseHtmlString(blog.body);

                var blogContentShort = blogContent.length > 40
                    ? blogContent.substring(0, 40) + "..."
                    : blogContent;

                return blogItem(
                  context: context,
                  blogAuthor: blog.user.name,
                  //blogContent: blog.body,
                  blogContent: blogContentShort,
                  blogTitle: blog.title,
                  commentsCount: blog.replies,
                  imageUrl: blog.user.avatarUrl,
                  viewsCount: blog.views,
                  blogId: blog.id,
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget blogItem(
      {BuildContext context,
      String blogTitle,
      String blogContent,
      String imageUrl,
      String blogAuthor,
      String commentsCount,
      String viewsCount,
      int blogId}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Color(0xFF7EC6C2), style: BorderStyle.solid, width: 0.80),
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new BlogArticle(postId: blogId);
          }));
        },
        leading: Container(
          height: 60.0,
          width: 60.0,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                blogTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0),
              ),
              SizedBox(height: 7.0),
              Text(
                blogContent,
                style: TextStyle(
                  color: Color(0xFFFEFEFE),
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 12.0),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'By $blogAuthor',
              style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  '$commentsCount Comments',
                  style: TextStyle(
                    color: Color(0xFFFEFEFE),
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  '$viewsCount Views',
                  style: TextStyle(
                    color: Color(0xFFFEFEFE),
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container allBlogsTextHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        'All Blogs',
        style: TextStyle(
          fontSize: 22.0,
          color: primaryTextColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
