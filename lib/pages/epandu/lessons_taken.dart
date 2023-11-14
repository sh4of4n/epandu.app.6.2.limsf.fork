import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common_library/services/model/epandu_model.dart' as epandu_model;
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/app_localizations.dart';
import '../../common_library/utils/local_storage.dart';

@RoutePage(name: 'lessonsTaken')
class LessonsTaken extends StatefulWidget {
  const LessonsTaken({super.key});

  @override
  State<LessonsTaken> createState() => _LessonsTakenState();
}

class _LessonsTakenState extends State<LessonsTaken> {
  final List<Map<String, String>> data = [];
  final epanduRepo = EpanduRepo();
  final authRepo = AuthRepo();
  var _lessonHistoryData;
  final localStorage = LocalStorage();
  String userName = '';
  String instituteLogoPath = '';
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    _getLessonTakenHistory();
  }

  Future<dynamic> _getLessonTakenHistory() async {
    userName = (await localStorage.getName())!;
    instituteLogoPath = (await localStorage.getInstituteLogo())!;
    if (!context.mounted) return;
    var result = await epanduRepo.getStuPracByCode(context: context);

    if (result.isSuccess) {
      setState(() {
        _lessonHistoryData = result.data;
      });
    } else {
      setState(() {
        _lessonHistoryData = result.message;
      });
    }

    setState(() {
      _isLoading = false;
      userName = userName;
      instituteLogoPath = instituteLogoPath;
    });
  }

  _loadHistoryData() {
    if (_isLoading && _lessonHistoryData == null) {
      return const Column(
        children: <Widget>[
          Expanded(
            child: SpinKitFoldingCube(
              color: Colors.blue,
            ),
          ),
        ],
      );
    } else if (!_isLoading && _lessonHistoryData is String) {
      return Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                _lessonHistoryData,
              ),
            ),
          ),
        ],
      );
    }
    List<epandu_model.StuPrac>? stuPrcaList;
    try {
      stuPrcaList =
          (_lessonHistoryData as List<dynamic>).cast<epandu_model.StuPrac>();
    } catch (e) {
      stuPrcaList = null; // Handle the case where casting fails
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: FadeInImage(
            alignment: Alignment.center,
            fit: BoxFit.contain,
            placeholder: MemoryImage(kTransparentImage),
            image: (instituteLogoPath.isNotEmpty
                ? NetworkImage(instituteLogoPath)
                : MemoryImage(kTransparentImage)) as ImageProvider<Object>,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              const Text(
                'NRIC:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  width: 8.0), // Add some space between the colon and NRIC NO
              Text(
                _lessonHistoryData[0].icNo ?? '',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              const Text(
                'Name:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  width: 8.0), // Add some space between the colon and the name
              Text(
                userName.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations.of(context)!.translate('schedule'),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildDataTable(stuPrcaList)),
      ],
    );
  }

  Widget buildDataTable(List<epandu_model.StuPrac>? stcpraList) {
    if (stcpraList == null || stcpraList.isEmpty) {
      return const SizedBox(); // Return an empty widget if the list is null or empty
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: DataTable(
          showCheckboxColumn: false,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey), // Border for the entire DataTable
          ),
          columns: const [
            DataColumn(
              label: Text(
                'GROUP ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'DATE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'COURSE CODE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'FROM:TO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'VEH.NO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: stcpraList.asMap().entries.map((entry) {
            final lessons = entry.value;
            final index = entry.key;
            final isEvenIndex = index % 2 == 0;
            final itemColor = MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
                if (isEvenIndex) {
                  return Colors.grey[200]!; // Color when the cell is pressed
                }
                return Colors.white; // Default color
              },
            );

            // DateTime startdateTime = DateTime.parse(lessons.startDate.toString());
            // String formattedTime =
            //     DateFormat('h:mm a', 'en_US').format(dateTime.toLocal());
            String formattedactBgTime = '';
            String formattedactEndTime = '';
            if (lessons.actBgTime != null && lessons.actBgTime != '') {
              DateTime parsedactBgTime =
                  DateFormat('HH:mm:ss').parse(lessons.actBgTime!);
              formattedactBgTime =
                  DateFormat('hh:mm a').format(parsedactBgTime);
            }
            if (lessons.actEndTime != null && lessons.actEndTime != '') {
              DateTime parsedactEndTime =
                  DateFormat('HH:mm:ss').parse(lessons.actEndTime!);
              formattedactEndTime =
                  DateFormat('hh:mm a').format(parsedactEndTime);
            }
            return DataRow(
              color: itemColor,
              onSelectChanged: (_) {
                createDataDialog(
                    lessons.groupId.toString(),
                    convertToDdMmYyyy(lessons.trandate.toString()),
                    lessons.courseCode.toString(),
                    '$formattedactBgTime\n$formattedactEndTime',
                    lessons.vehNo.toString());
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Lesson Details'),
                      content: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text('Name'),
                              ),
                              DataColumn(
                                label: Text('Value'),
                              ),
                            ],
                            rows: data.map((rowData) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text(rowData['Header'] ?? ''),
                                  ),
                                  DataCell(
                                    Text(rowData['Value'] ?? ''),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              cells: [
                DataCell(Text(lessons.groupId.toString())),
                DataCell(Text(convertToDdMmYyyy(lessons.trandate.toString()))),
                DataCell(Text(lessons.courseCode != null
                    ? lessons.courseCode.toString()
                    : '')),
                DataCell(Text('$formattedactBgTime\n$formattedactEndTime')),
                DataCell(Text(
                    lessons.vehNo != null ? lessons.vehNo.toString() : '')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String convertToDdMmYyyy(String input) {
    DateTime dateTime = DateTime.parse(input);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  List<Map<String, String>> createDataDialog(String? groupId, String? date,
      String? coursecode, String? time, String? vehNo) {
    data.clear();
    data.add({
      'Header': 'Group Id',
      'Value': groupId != null ? groupId.toString() : ''
    });
    data.add({'Header': 'Date', 'Value': date != null ? date.toString() : ''});
    data.add({
      'Header': 'Course',
      'Value': coursecode != null ? coursecode.toString() : ''
    });
    data.add({'Header': 'Time', 'Value': time != null ? time.toString() : ''});
    data.add({
      'Header': 'Vehicle No.',
      'Value': vehNo != null ? vehNo.toString() : ''
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdc013),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'LESSONS TAKEN',
        ),
      ),
      body: _loadHistoryData(),
    );
  }
}
