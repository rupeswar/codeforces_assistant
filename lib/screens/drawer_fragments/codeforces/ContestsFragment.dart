import 'package:codeforces_assistant/models/Contest.dart';
import 'package:codeforces_assistant/services/CodeforcesAPIService.dart';
import 'package:codeforces_assistant/utils/SizeUtil.dart';
import 'package:codeforces_assistant/utils/TimeUtil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContestsFragment extends StatefulWidget {
  @override
  _ContestsFragmentState createState() => _ContestsFragmentState();
}

class _ContestsFragmentState extends State<ContestsFragment>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool dataIsReady;
  List<List<Contest>> _contests;
  SizeUtil size;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    dataIsReady = false;
  }

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width;
    var heightPiece = MediaQuery.of(context).size.height;
    size = SizeUtil(heightPiece, widthPiece);
    if (!dataIsReady) {
      fetchData();
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Material(
          color: Colors.blue,
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Text(
                  'UPCOMING',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  'PAST',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: _tabController,
            children: [
              buildListView(_contests[0]),
              buildListView(_contests[1]),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> fetchData() async {
    _contests = await CodeforcesAPIService.getAllContests();

    setState(() {
      dataIsReady = true;
    });
  }

  ListView buildListView(List<Contest> contests) {
    return ListView.builder(
        itemCount: contests.length,
        itemBuilder: (context, index) {
          return ContestTile(
            contest: contests[index],
            size: size,
          );
        });
  }
}

class ContestTile extends StatelessWidget {
  final Contest contest;
  final SizeUtil size;

  ContestTile({Key key, @required this.contest, @required this.size})
      : super(key: key);

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
                    formatLine(contest.name, ''),
                    formatLine(
                        'Starts At: ',
                        TimeUtil.getDateAndTime(
                            contest.startTimeSeconds * 1000)),
                    formatLine('Duration: ',
                        TimeUtil.getDuration(contest.durationSeconds * 1000)),
                  ],
                ),
              )),
            ],
          ),
          Positioned.fill(
            child: InkWell(
              onTap: () async {
                bool isSuccessful = await launch(
                    CodeforcesAPIService.getContestURL(contest.id));

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
