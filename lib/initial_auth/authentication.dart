import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  void initState() {
    super.initState();

    _checkExistingLogin();
  }

  _checkExistingLogin() async {
    String userId = await LocalStorage().getUserId();

    if (userId.isNotEmpty) {
      Navigator.pushReplacementNamed(context, HOME);
    } else {
      Navigator.pushReplacementNamed(context, LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
