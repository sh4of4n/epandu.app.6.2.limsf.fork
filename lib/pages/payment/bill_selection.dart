import 'package:epandu/services/repo/bill_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';

class BillSelection extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;
  final billRepo = BillRepo();

  Future _getTelco(context) async {
    await billRepo.getTelco(context: context);
  }

  Future _getService(context) async {
    await billRepo.getService(context: context);
  }

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Bill'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder(
              future: _getTelco(context),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Container();
                }
                return Container();
              },
            ),
            FutureBuilder(
              future: _getService(context),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Container();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
