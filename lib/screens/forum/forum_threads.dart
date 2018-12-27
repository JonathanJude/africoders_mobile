import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/model/forumThreadModel.dart';
import 'package:africoders_mobile/repo/forumThreadListRepo.dart';
import 'package:africoders_mobile/screens/forum/create_thread.dart';
import 'package:africoders_mobile/screens/forum/forum_topic.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/date_time_formats.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:http/http.dart' as http;

class ForumThreads extends StatefulWidget {
  final String forumPath;
  final String forumName;
  final String forumId;
  ForumThreads(
      {@required this.forumPath,
      @required this.forumName,
      @required this.forumId});
  _ForumThreadsState createState() => _ForumThreadsState();
}

class _ForumThreadsState extends State<ForumThreads> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(context: context),
      backgroundColor: mainBgColor,
      appBar: buildAppBar(context),
      body: FutureBuilder<List<ForumThread>>(
        future: fetchForumThreadList(http.Client(), widget.forumPath),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ForumThreadList(
                  forumName: widget.forumName,
                  threads: snapshot.data,
                )
              : Center(
                  child: AfricodersLoader(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new CreateforumThread(forumId: widget.forumId);
          }));
        },
        backgroundColor: Color(0xFF9CE0AD),
        child: Icon(
          Icons.add,
          color: Color(0xFF547A7D),
        ),
      ),
    );
  }
}

class ForumThreadList extends StatelessWidget {
  final String forumName;
  final List<ForumThread> threads;
  ForumThreadList({@required this.threads, @required this.forumName});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        //Forum Title Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              forumName,
              style: TextStyle(
                  fontSize: 30.0,
                  color: primaryTextColor,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        SizedBox(height: 30.0),

        Column(
          children: threads
              .map(
                (thread) => buildForumTopic(
                      context,
                      topicTitle: thread.title,
                      topicCreator: thread.user.name,
                      repliesCount: thread.replies,
                      lastPostTime: thread.updated.date,
                      postId: thread.id,
                    ),
              )
              .toList(),
        )
      ],
    );
  }

  Widget buildForumTopic(
    BuildContext context, {
    String topicTitle,
    String topicCreator,
    String repliesCount,
    String lastPostTime,
    String lastPostUser,
    int postId,
  }) {
    lastPostTime = dateAndTimeFormatter(lastPostTime);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Divider(
          color: Colors.grey,
          height: 1.0,
        ),
        SizedBox(height: 5.0),
        ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new ForumTopicScreen(postId: postId);
            }));
          },
          leading: int.parse(repliesCount) > 10
              ? Icon(Icons.trending_up, color: primaryTextColor)
              : Icon(Icons.chat_bubble, color: primaryTextColor),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  topicTitle,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3.0),
                child: Text(
                  'Started by $topicCreator  ~  ${repliesCount == "0" ? 'No' : repliesCount} Replies  ~  Last Reply: $lastPostTime',
                  style: TextStyle(
                    color: Color(0xFFFEFEFE),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              )
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: primaryTextColor,
            //color: Color(0xFFFEFEFE),
            size: 16,
          ),
        ),
      ],
    );
  }
}
