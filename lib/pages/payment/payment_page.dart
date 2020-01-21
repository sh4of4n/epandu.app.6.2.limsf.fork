import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;

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
          title: Text('Payment'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: Offset(0, 8),
                  spreadRadius: 2,
                  color: Colors.black26,
                ),
              ]),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                onTap: () => Navigator.pushNamed(context, BILL_SELECTION),
                leading: Icon(Icons.attach_money),
                title: Text('Bills'),
              ),
              // ListTile(
              //   onTap: () {},
              //   title: Text('Top-up'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
