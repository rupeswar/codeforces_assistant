class User {
  String imageURL, handle, rank, maxRank;
  int rating, maxRating;
  User({
    this.imageURL,
    this.handle,
    this.rating,
    this.maxRating,
    this.rank,
    this.maxRank,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var userData = json['result'];

    if (userData == null) return null;

    userData = userData[0];

    return User(
      imageURL: '${userData['titlePhoto']}',
      handle: userData['handle'],
      rating: userData['rating'],
      maxRating: userData['maxRating'],
      rank: userData['rank'],
      maxRank: userData['maxRank'],
    );
  }
}
