import 'package:codeforces_assistant/models/RatingChange.dart';
import 'package:codeforces_assistant/services/CodeforcesAPIService.dart';
import 'package:codeforces_assistant/utils/SizeUtil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContestHistoryFragment extends StatelessWidget {
  List<RatingChange> ratingChanges;
  double widthPiece, heightPiece;
  SizeUtil size;

  ContestHistoryFragment({Key key, @required this.ratingChanges})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    widthPiece = MediaQuery.of(context).size.width;
    heightPiece = MediaQuery.of(context).size.height;
    size = SizeUtil(heightPiece, widthPiece);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contest History'),
      ),
      body: ListView.builder(
        itemCount: ratingChanges.length,
        itemBuilder: (context, index) {
          return RatingChangeTile(
            ratingChange: ratingChanges[index],
            size: size,
          );
        },
      ),
    );
  }
}

class RatingChangeTile extends StatelessWidget {
  RatingChange ratingChange;
  SizeUtil size;

  RatingChangeTile({Key key, this.ratingChange, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/ic_codeforces.png',
                height: size.size(200),
                fit: BoxFit.fitHeight,
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(size.size(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      formatLine(
                        ratingChange.name,
                        "",
                      ),
                      formatLine(
                        "Rank: ",
                        "${ratingChange.rank}",
                      ),
                      formatLine(
                        "Old Rating: ",
                        "${ratingChange.oldRating}",
                      ),
                      formatLine(
                        "Rating Change: ",
                        "${ratingChange.change}",
                      ),
                      formatLine(
                        "New Rating: ",
                        "${ratingChange.newRating}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: InkWell(
              onTap: () async {
                bool isSuccessful = await launch(
                    CodeforcesAPIService.getContestURL(ratingChange.cid));

                if (!isSuccessful)
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Some Error Occurred! Please try again.')));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget formatLine(String b, String n) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.size(5),
      ),
      child: RichText(
          text: TextSpan(
        style: TextStyle(
          fontSize: size.size(30),
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: b,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: n,
          ),
        ],
      )),
    );
  }
}
