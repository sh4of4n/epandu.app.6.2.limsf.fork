import 'package:auto_route/auto_route.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['D', 'DA'];
List<Map<String, Object>> fileList = [
  {
    'name': 'abc',
    'date': '2021-01-01',
    'type': 'pdf',
    'groupId': 'D',
    'url': 'https://www.africau.edu/images/default/sample.pdf'
  },
  {
    'name': 'abc',
    'date': '2021-01-01',
    'type': 'video',
    'groupId': 'DA',
    'url':
        'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4'
  }
];

class BriefListPage extends StatefulWidget {
  const BriefListPage({super.key});

  @override
  State<BriefListPage> createState() => _BriefListPageState();
}

class _BriefListPageState extends State<BriefListPage> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brief List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Group ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0,
                );
              },
              itemCount: fileList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    // context.router.push(
                    //   BriefDetailRoute(fileDetail: fileList[index]),
                    // );
                    print(fileList[index]['url'].toString());
                    context.router.push(
                      ViewPdf(
                        title: 'title',
                        pdfLink: fileList[index]['url'].toString(),
                      ),
                    );
                  },
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      fileList[index]['type'] == 'pdf'
                          ? Icon(
                              Icons.picture_as_pdf,
                            )
                          : Icon(
                              Icons.video_library,
                            ),
                    ],
                  ),
                  title: Text(fileList[index]['name'].toString()),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
