import 'package:epandu/services/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:epandu/utils/route_path.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final api = ProfileRepo();
  var tagResult;
  var quoteResult;
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Donald Trump'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.pushNamed(context, ABOUT);
              },
            ),
          ],
        ),
        body: TabBarView(children: [
          LoadTags(count, tagResult),
          RandomQuotes(randomQuote, randomQuoteCreatedAt, randomQuoteSource),
          RandomMeme(),
        ]),
        bottomNavigationBar: Material(
          color: primaryColor,
          child: TabBar(
            indicatorColor: amberAccent,
            // labelColor: primaryColor,
            // unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                  icon: new Icon(
                    Icons.account_circle,
                  ),
                  text: 'ProfileTab'),
              Tab(
                  icon: new Icon(
                    Icons.library_books,
                  ),
                  text: 'Quotes'),
              Tab(
                  icon: new Icon(
                    Icons.camera,
                  ),
                  text: 'Memes'),
            ],
          ),
        ),
      ),
    );
  }
}
