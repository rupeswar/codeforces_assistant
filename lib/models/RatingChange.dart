class RatingChange {
  int cid, rank, oldRating, newRating, change;
  String name;

  RatingChange({
    this.cid,
    this.name,
    this.rank,
    this.oldRating,
    this.newRating,
  }) {
    change = newRating - oldRating;
  }

  factory RatingChange.fromJson(Map<String, dynamic> json) {
    return RatingChange(
      cid: json['contestId'],
      name: json['contestName'],
      rank: json['rank'],
      oldRating: json['oldRating'],
      newRating: json['newRating'],
    );
  }

  static List<RatingChange> listFromJson(Map<String, dynamic> json) {
    List ratingChangeJsonArray = json['result'];

    if (ratingChangeJsonArray == null) return null;

    var ratingChangeArray = List<RatingChange>.filled(0, null, growable: true);

    ratingChangeJsonArray.forEach((ratingChange) {
      ratingChangeArray.add(RatingChange.fromJson(ratingChange));
    });

    return ratingChangeArray.reversed.toList();
  }
}
