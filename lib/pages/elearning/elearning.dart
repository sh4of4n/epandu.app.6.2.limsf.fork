import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
//import 'package:scroll_app_bar/scroll_app_bar.dart';

@RoutePage()
class ElearningPage extends StatefulWidget {
  const ElearningPage({Key? key}) : super(key: key);

  @override
  State<ElearningPage> createState() => _ElearningPageState();
}

class _ElearningPageState extends State<ElearningPage> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO
      // appBar: ScrollAppBar(
      //   controller: controller, // Note the controller here
      //   title: const Text("eLearning"),
      // ),
      appBar: AppBar(
        title: const Text("eLearning"),
      ),
      body: SafeArea(
        child: ListView.separated(
          controller: controller,
          padding: const EdgeInsets.all(16.0),
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 16,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://tbsweb.tbsdns.com/WebCache/epandu_devp_3/EPANDU/R3W77BWEY6B6TQI7DB5YM5RC5Q/image/Feed/RW42FFIRRQSB4LGEN3ZX2FWOKM_n0_20210628181116.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Kelayakan Memgambil Lesen D/DA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
