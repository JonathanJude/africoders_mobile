import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/model/jobAdModel.dart';
import 'package:africoders_mobile/screens/job_ads/job_article.dart';
import 'package:flutter/material.dart';

class JobList extends StatelessWidget {
  final List<JobAd> jobs;

  JobList({this.jobs});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          jobsTextHeader(),
          Column(
            children: jobs.map(
              (job) {
                return jobItem(
                    context: context,
                    jobAuthor: job.user.name,
                    //jobContent: job.body,
                    //jobContent: jobContent,
                    jobTitle: job.title,
                    commentsCount: job.replies,
                    imageUrl: job.user.avatarUrl,
                    viewsCount: job.views,
                    jobId: job.id);
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget jobItem(
      {BuildContext context,
      String jobTitle,
      String jobContent,
      String imageUrl,
      String jobAuthor,
      String commentsCount,
      String viewsCount,
      int jobId}) {
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
            return new JobArticle(postId: jobId);
          }));
        },
        leading: Container(
          height: 70.0,
          width: 70.0,
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
                jobTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 19.0),
              ),
              /* SizedBox(height: 7.0),
              Text(
                jobContent,
                style: TextStyle(
                  color: Color(0xFFFEFEFE),
                  fontSize: 12.0,
                ),
              ), */
              SizedBox(height: 12.0),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'By $jobAuthor',
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

  Container jobsTextHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        'Job Adverts',
        style: TextStyle(
            color: primaryTextColor,
            fontSize: 22.0,
            fontWeight: FontWeight.w300),
      ),
    );
  }
}
