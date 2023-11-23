import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/pages/home/feeds.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage(name: 'Multilevel')
class Multilevel extends StatefulWidget {
  final feed;
  final String? appVersion;

  const Multilevel({super.key, this.feed, this.appVersion});

  @override
  State<Multilevel> createState() => _MultilevelState();
}

class _MultilevelState extends State<Multilevel> {
  final primaryColor = ColorConstant.primaryColor;
  final authRepo = AuthRepo();

  int _startIndex = 0;

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  final adText = TextStyle(
    fontSize: ScreenUtil().setSp(70),
    fontWeight: FontWeight.bold,
    color: const Color(0xff231f20),
  );

  List<dynamic> items = [];
  final ScrollController _scrollController = ScrollController();
  String? _message = '';
  bool _loadMore = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    getActiveFeed();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _startIndex += 10;
        });

        if (_message!.isEmpty) {
          setState(() {
            _loadMore = true;
          });

          getActiveFeed();
        }
      }
    });
  }

  Future<dynamic> getActiveFeed() async {
    setState(() {
      _isLoading = true;
    });

    var result = await authRepo.getActiveFeed(
      context: context,
      feedType: 'MAIN',
      startIndex: _startIndex,
      noOfRecords: 10,
      sourceDocDoc: widget.feed.docDoc,
      sourceDocRef: widget.feed.docRef,
    );

    /* if (result.isSuccess) {
      setState(() {
        feed = result.data;
      });
    } */

    if (result.isSuccess) {
      if (result.data!.isNotEmpty && mounted) {
        setState(() {
          for (int i = 0; i < result.data!.length; i += 1) {
            items.add(result.data![i]);
          }
        });
      } else if (mounted) {
        setState(() {
          _loadMore = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _message = result.message;
          _loadMore = false;
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  shimmer() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
      child: Column(
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.white,
            child: Container(
              width: ScreenUtil().setWidth(1300),
              height: ScreenUtil().setHeight(750),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            primaryColor,
          ],
          stops: const [0.45, 0.65],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Feeds',
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _startIndex = 0;
              items.clear();
              _message = '';
            });

            getActiveFeed();
          },
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Feeds(
                  feed: items,
                  isLoading: _isLoading,
                  appVersion: widget.appVersion,
                ),
              ),
              if (_loadMore) shimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
