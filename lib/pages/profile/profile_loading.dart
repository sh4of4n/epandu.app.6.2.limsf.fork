import 'package:flutter/material.dart';

class ProfileLoading extends StatelessWidget {
  final message;

  ProfileLoading(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
