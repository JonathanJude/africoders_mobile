import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/model/linkShareModel.dart';
import 'package:africoders_mobile/screens/link/link_article.dart';
import 'package:flutter/material.dart';

class LinkList extends StatelessWidget {
  final List<LinkShare> links;

  LinkList({this.links});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          linksTextHeader(),
          Column(
            children: links.map(
              (link) {
                return linkItem(
                  context: context,
                  linkAuthor: link.user.name,
                  linkContent: link.body,
                  linkUrl: link.url,
                  linkTitle: link.title,
                  commentsCount: link.replies,
                  imageUrl: link.user.avatarUrl,
                  viewsCount: link.views,
                  linkId: link.id,
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget linkItem({
    BuildContext context,
    String linkTitle,
    String linkContent,
    String linkUrl,
    String imageUrl,
    String linkAuthor,
    String commentsCount,
    String viewsCount,
    int linkId,
  }) {
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
            return new LinkArticle(postId: linkId);
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
                linkTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 17.0),
              ),
              SizedBox(height: 12.0),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'By $linkAuthor',
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

  Container linksTextHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        'Shared Links',
        style: TextStyle(
            color: primaryTextColor,
            fontSize: 22.0,
            fontWeight: FontWeight.w800),
      ),
    );
  }
}
