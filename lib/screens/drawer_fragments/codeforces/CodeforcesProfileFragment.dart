import 'package:codeforces_assistant/models/User.dart';
import 'package:codeforces_assistant/screens/drawer_fragments/codeforces/ContestHistoryFragment.dart';
import 'package:codeforces_assistant/services/CodeforcesAPIService.dart';
import 'package:codeforces_assistant/utils/SizeUtil.dart';
import 'package:codeforces_assistant/utils/dialogs.dart';
import 'package:codeforces_assistant/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeforcesProfileFragment extends StatefulWidget {
  @override
  _CodeforcesProfileFragmentState createState() =>
      _CodeforcesProfileFragmentState();
}

class _CodeforcesProfileFragmentState extends State<CodeforcesProfileFragment> {
  bool _dataIsReady = false;
  User user;
  double widthPiece, heightPiece;
  SizeUtil size;
  String handle = 'tourist';

  @override
  Widget build(BuildContext context) {
    widthPiece = MediaQuery.of(context).size.width;
    heightPiece = MediaQuery.of(context).size.height;
    size = SizeUtil(heightPiece, widthPiece);

    if (!_dataIsReady) getUser(handle);

    return Center(
      child: _dataIsReady ? buildUserWidget() : CircularProgressIndicator(),
    );
  }

  Widget buildUserWidget() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            user.imageURL,
            height: size.heightPercent(20),
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.heightPercent(5)),
            child: Text(
              user.handle,
              style: TextStyle(
                fontSize: size.size(60),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: size.heightPercent(20),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.widthPercent(10)),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.widthPercent(2.5),
                    vertical: size.size(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Current Rating',
                              style: TextStyle(
                                fontSize: size.size(30),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              '${user.rating}',
                              style: TextStyle(fontSize: size.size(30)),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Max Rating',
                              style: TextStyle(
                                fontSize: size.size(30),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              '${user.maxRating}',
                              style: TextStyle(fontSize: size.size(30)),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Current Rank',
                              style: TextStyle(
                                fontSize: size.size(30),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              '${user.rank}',
                              style: TextStyle(fontSize: size.size(30)),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Max Rank',
                              style: TextStyle(
                                fontSize: size.size(30),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              '${user.maxRank}',
                              style: TextStyle(fontSize: size.size(30)),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.heightPercent(5),
              horizontal: size.widthPercent(5),
            ),
            child: CustomButton(
              child: Padding(
                padding: EdgeInsets.all(size.size(20)),
                child: Text(
                  'Contest History',
                  style: TextStyle(
                    fontSize: size.size(30),
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              autoSize: true,
              onPressed: () async {
                var ratingChanges =
                    await CodeforcesAPIService.getContestHistory(
                        userId: handle);
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => ContestHistoryFragment(
                    ratingChanges: ratingChanges,
                  ),
                ));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          showChangeUserNameDialog();
        },
      ),
    );
  }

  Future<void> getUser(String handle) async {
    user = await CodeforcesAPIService.getUser(userId: handle);

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Handle')));
      showChangeUserNameDialog();
      return;
    }

    setState(() {
      _dataIsReady = true;
    });
  }

  void showChangeUserNameDialog() {
    showDialog(
      context: context,
      builder: (context) => ChangeHandleDialog(
        onPressed: (newHandle) {
          setState(() {
            _dataIsReady = false;
            handle = newHandle;
          });
        },
      ),
    );
  }
}
