import 'package:auto_route/auto_route.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KppResult extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;
  final data;
  final descStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  final resultStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.blue);

  KppResult(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Response'),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 1),
                        blurRadius: 2,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Correct Answers', style: descStyle),
                    Text('${data.correct}/${data.totalQuestions}',
                        style: resultStyle),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 1),
                        blurRadius: 2,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Incorrect Answers', style: descStyle),
                    Text('${data.incorrect}/${data.totalQuestions}',
                        style: resultStyle),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              ButtonTheme(
                padding: EdgeInsets.all(0.0),
                shape: StadiumBorder(),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(color: Colors.white),
                    padding: const EdgeInsets.all(0.0),
                  ),
                  onPressed: () {
                    ExtendedNavigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent.shade700, Colors.blue],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 15.0,
                    ),
                    child: Text(
                      'DONE',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(56),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
