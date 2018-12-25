import 'package:flutter/material.dart';

class PostIcons extends StatelessWidget {
  final int postId;
  final int likesCount;
  final int disLikesCount;
  final int sharesCount;
  PostIcons({
    this.postId,
    this.likesCount,
    this.disLikesCount,
    this.sharesCount,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        postIconButton(Icons.thumb_up, likesCount.toString()),
        postIconButton(Icons.thumb_down, disLikesCount.toString()),
        postIconButton(Icons.share, sharesCount.toString()),
      ],
    ));
  }

  Widget postIconButton(IconData icon, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
          color: Color(0xFF45ADA6),
          iconSize: 18,
        ),
        Text(
          count,
          style: TextStyle(fontSize: 15, color: Color(0xFF45ADA6)),
        )
      ],
    );
  }
}
