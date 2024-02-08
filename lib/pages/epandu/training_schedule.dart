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

@RoutePage(name: 'trainingSchedule')
class TrainingSchedule extends StatefulWidget {
  const TrainingSchedule({super.key});

  @override
  State<TrainingSchedule> createState() => _TrainingScheduleState();
}

class _TrainingScheduleState extends State<TrainingSchedule> {
  final List<Map<String, String>> data = [];
  final epanduRepo = EpanduRepo();
  final authRepo = AuthRepo();
  var _scheduleHistoryData;
  final localStorage = LocalStorage();
  String userName = '';
  String instituteLogoPath = '';
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    _getEnrollHistory();
  }

  Future<dynamic> _getEnrollHistory() async {
    userName = (await localStorage.getName())!;
    instituteLogoPath = (await localStorage.getInstituteLogo())!;
    //String? userId = await localStorage.getUserId();
    var result =
        await epanduRepo.getTimeTableListByIcNo(groupId: '', startIndex: 0);
    if (!mounted) return;
    if (result.isSuccess) {
      setState(() {
        _scheduleHistoryData = result.data;
      });
    } else {
      setState(() {
        _scheduleHistoryData = result.message;
      });
    }

    setState(() {
      _isLoading = false;
      userName = userName;
      instituteLogoPath = instituteLogoPath;
    });
  }

  _loadHistoryData() {
    if (_isLoading && _scheduleHistoryData == null) {
      return const Column(
        children: <Widget>[
          Expanded(
            child: SpinKitFoldingCube(
              color: Colors.blue,
            ),
          ),
        ],
      );
    } else if (!_isLoading && _scheduleHistoryData is String) {
      return Center(
        child: Text(
          _scheduleHistoryData,
        ),
      );
    }
    List<epandu_model.TimeTable>? timetableList;
    try {
      timetableList = (_scheduleHistoryData as List<dynamic>)
          .cast<epandu_model.TimeTable>();
    } catch (e) {
      timetableList = null; // Handle the case where casting fails
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
                _scheduleHistoryData[0].icNo ?? '',
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
            child: buildDataTable(timetableList)),
      ],
    );
  }

  Widget buildDataTable(List<epandu_model.TimeTable>? timetableList) {
    if (timetableList == null || timetableList.isEmpty) {
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
                'TIME',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'COURSES',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          // rows: timetableList.map((timetable) {
          rows: timetableList.asMap().entries.map((entry) {
            final timetable = entry.value;
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
            //print('index:$index');
            DateTime startdateTime =
                DateTime.parse(timetable.startDate.toString());
            String startTime =
                DateFormat('h:mm a', 'en_US').format(startdateTime.toLocal());

            DateTime enddateTime = DateTime.parse(timetable.endDate.toString());
            String endTime =
                DateFormat('h:mm a', 'en_US').format(enddateTime.toLocal());

            return DataRow(
              color: itemColor,
              onSelectChanged: (_) {
                createDataDialog(
                    timetable.groupId.toString(),
                    convertToDdMmYyyy(timetable.startDate.toString()),
                    '$startTime-$endTime',
                    timetable.courseCode.toString());
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Schedule Details'),
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
                DataCell(
                  Text(timetable.groupId.toString()),
                ),
                DataCell(
                    Text(convertToDdMmYyyy(timetable.startDate.toString()))),
                DataCell(Text('$startTime - $endTime')),
                DataCell(Text(timetable.courseCode.toString())),
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

  List<Map<String, String>> createDataDialog(
      String groupId, String date, String time, String courses) {
    data.clear();
    data.add({'Header': 'Group Id', 'Value': groupId.toString()});
    data.add({'Header': 'Date', 'Value': date});
    data.add({'Header': 'Time', 'Value': time});
    data.add({'Header': 'Course', 'Value': courses});
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdc013),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.translate('training_schedule'),
        ),
      ),
      body: _loadHistoryData(),
    );
  }
}
