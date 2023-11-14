import 'package:flutter/material.dart';

class ProfileLoading extends StatelessWidget {
  final message;

  const ProfileLoading(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
