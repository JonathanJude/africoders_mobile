class ForumBoardModel {
  String category;
  String container;
  String board;
  String path;
  String fid;
  String pid;
  String tid;
  String views;
  String threads;
  String comments;
  String lastPost;
  String lastReply;
  String latest;

  ForumBoardModel({
    this.category,
    this.container,
    this.board,
    this.path,
    this.fid,
    this.pid,
    this.tid,
    this.views,
    this.threads,
    this.comments,
    this.lastPost,
    this.lastReply,
    this.latest,
  });

  factory ForumBoardModel.fromMap(Map<String, dynamic> map) {
    return ForumBoardModel(
        category: map['category'],
        container: map['container'],
        board: map['board'],
        path: map['path'],
        fid: map['fid'],
        pid: map['pid'],
        tid: map['tid'],
        views: map['views'],
        threads: map['threads'],
        comments: map['comments'],
        lastPost: map['last_post'],
        lastReply: map['last_reply'],
        latest: map['latest']);
  }
}
