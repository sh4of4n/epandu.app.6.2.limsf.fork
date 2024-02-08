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

@RoutePage(name: 'testScheduleResult')
class TestScheduleResult extends StatefulWidget {
  const TestScheduleResult({super.key});

  @override
  State<TestScheduleResult> createState() => _TestScheduleResultState();
}

class _TestScheduleResultState extends State<TestScheduleResult> {
  final List<Map<String, String>> data = [];
  final epanduRepo = EpanduRepo();
  final authRepo = AuthRepo();
  var _testscheduleResultData;
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
    if (!context.mounted) return;
    //String? userId = await localStorage.getUserId();
    var result = await epanduRepo.getDTestByCode(context: context);
    if (!mounted) return;
    if (result.isSuccess) {
      setState(() {
        _testscheduleResultData = result.data;
      });
    } else {
      setState(() {
        _testscheduleResultData = result.message;
      });
    }

    setState(() {
      _isLoading = false;
      userName = userName;
      instituteLogoPath = instituteLogoPath;
    });
  }

  _loadHistoryData() {
    if (_isLoading && _testscheduleResultData == null) {
      return const Column(
        children: <Widget>[
          Expanded(
            child: SpinKitFoldingCube(
              color: Colors.blue,
            ),
          ),
        ],
      );
    } else if (!_isLoading && _testscheduleResultData is String) {
      return Center(
        child: Text(
          _testscheduleResultData,
        ),
      );
    }
    List<epandu_model.DTest>? dtestList;
    try {
      dtestList =
          (_testscheduleResultData as List<dynamic>).cast<epandu_model.DTest>();
    } catch (e) {
      dtestList = null; // Handle the case where casting fails
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
                _testscheduleResultData[0].icNo ?? '',
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
            child: buildDataTable(dtestList)),
      ],
    );
  }

  Widget buildDataTable(List<epandu_model.DTest>? dtestList) {
    if (dtestList == null || dtestList.isEmpty) {
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
                'TEST\nDATE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'TEST\nTYPE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'RESULT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
          rows: dtestList.asMap().entries.map((entry) {
            final dtest = entry.value;
            final index = entry.key;
            final isEvenIndex = index % 2 == 0;
            final itemColor = MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
                if (isEvenIndex) {
                  return Colors.grey[200]!;
                }
                return Colors.white;
              },
            );

            return DataRow(
              color: itemColor,
              onSelectChanged: (_) {
                createDataDialog(
                  dtest.groupId.toString(),
                  convertToDdMmYyyy(dtest.testDate.toString()),
                  dtest.testType != null ? dtest.testType.toString() : '',
                  dtest.result != null ? dtest.result.toString() : '',
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Test Schedule/Result Details'),
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
                  Text(dtest.groupId.toString()),
                ),
                DataCell(Text(convertToDdMmYyyy(dtest.testDate.toString()))),
                DataCell(Text(
                    dtest.testType != null ? dtest.testType.toString() : '')),
                DataCell(
                    Text(dtest.result != null ? dtest.result.toString() : '')),
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
      String groupId, String date, String testType, String result) {
    data.clear();
    data.add({'Header': 'Group Id', 'Value': groupId.toString()});
    data.add({'Header': 'Test Date', 'Value': date});
    data.add({'Header': 'Test Type', 'Value': testType});
    data.add({'Header': 'Result', 'Value': result});
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
          'TEST SCHEDULE AND RESULT',
        ),
      ),
      body: _loadHistoryData(),
    );
  }
}
