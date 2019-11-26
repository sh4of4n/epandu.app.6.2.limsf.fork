import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final authRepo = AuthRepo();
  final localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ePandu'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _logout,
        ),
      ),
    );
  }

  _logout() async {
    await authRepo.logout();
    Navigator.pushNamedAndRemoveUntil(context, LOGIN, (r) => false);
  }
}
