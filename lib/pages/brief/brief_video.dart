import 'package:flutter/material.dart';

class BriefVideoPage extends StatefulWidget {
  final Map<String, Object> fileDetail;
  const BriefVideoPage({
    super.key,
    required this.fileDetail,
  });

  @override
  State<BriefVideoPage> createState() => _BriefVideoPageState();
}

class _BriefVideoPageState extends State<BriefVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brief Detail'),
      ),
      body: Text('data'),
    );
  }
}
