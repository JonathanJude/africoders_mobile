final statusApi =
    'https://api.africoders.com/v1/posts?category=status&include=comment:order(id|asc)&order=published_at|desc&limit=20';

final blogWithNoCommentApi =
    'https://api.africoders.com/v1/posts?category=blog&order=published_at|desc&limit=20';

final blogWithCommentApi =
    'https://api.africoders.com/v1/posts?category=blog&include=comment:order(id|asc)&order=published_at|desc&limit=20';

final jobAdWithNoCommentApi =
    'https://api.africoders.com/v1/posts?category=job&order=published_at|desc&limit=20';

final jobAdWithCommentApi =
    'https://api.africoders.com/v1/posts?category=job&include=comment:order(id|asc)&order=published_at|desc&limit=20';

final linkShareWithNoCommentApi =
    'https://api.africoders.com/v1/posts?category=link&order=published_at|desc&limit=20';

final linkShareWithCommentApi =
    'https://api.africoders.com/v1/posts?category=link&include=comment:order(id|asc)&order=published_at|desc&limit=20';

final forumListingApi = 'https://api.africoders.com/v1/forums';
