import 'package:codeforces_assistant/models/User.dart';
import 'package:codeforces_assistant/services/CodeforcesAPIService.dart';
import 'package:codeforces_assistant/utils/dialogs.dart';
import 'package:flutter/material.dart';

class CodeforcesUserInfoFragment extends StatefulWidget {
  @override
  _CodeforcesUserInfoFragmentState createState() =>
      _CodeforcesUserInfoFragmentState();
}

class _CodeforcesUserInfoFragmentState
    extends State<CodeforcesUserInfoFragment> {
  bool _dataIsReady = false;
  User user;
  double widthPiece, heightPiece;
  String handle = 'tourist';

  @override
  Widget build(BuildContext context) {
    widthPiece = MediaQuery.of(context).size.width / 10;
    heightPiece = MediaQuery.of(context).size.height / 10;

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
            height: 2 * heightPiece,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5 * heightPiece),
            child: Text(
              user.handle,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 2 * heightPiece,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widthPiece),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widthPiece,
                    vertical: 20.0,
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              '${user.rating}',
                              style: TextStyle(fontSize: 20),
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              '${user.maxRating}',
                              style: TextStyle(fontSize: 20),
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              '${user.rank}',
                              style: TextStyle(fontSize: 20),
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              '${user.maxRank}',
                              style: TextStyle(fontSize: 20),
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
