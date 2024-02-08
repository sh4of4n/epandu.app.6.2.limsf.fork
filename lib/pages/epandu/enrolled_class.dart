import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../common_library/services/model/epandu_model.dart' as epandu_model;
import '../../common_library/services/model/epandu_model.dart';
import '../../common_library/utils/app_localizations.dart';
import '../../common_library/utils/local_storage.dart';

@RoutePage(name: 'enrolledClass')
class EnrolledClass extends StatefulWidget {
  const EnrolledClass({super.key});

  @override
  State<EnrolledClass> createState() => _EnrolledClassState();
}

class _EnrolledClassState extends State<EnrolledClass> {
  final List<Map<String, String>> data = [];
  final epanduRepo = EpanduRepo();
  final authRepo = AuthRepo();
  List<Map<String, String>> combinedList = [];
  final localStorage = LocalStorage();
  String userName = '';
  String instituteLogoPath = '';
  String icNo = '';
  bool _isLoading = true;
  String errorMsg = '';
  @override
  void initState() {
    super.initState();

    _getEnrollHistory();
  }

  Future<dynamic> _getEnrollHistory() async {
    List<epandu_model.Enroll>? enrollList;
    List<epandu_model.TimeTable>? timetableList;
    List<epandu_model.DTest>? dtestList;
    userName = (await localStorage.getName())!;
    instituteLogoPath = (await localStorage.getInstituteLogo())!;
    icNo = (await localStorage.getStudentIc())!;
    var result = await epanduRepo.getEnrollByCode(
      groupId: '',
    );
    if (!mounted) return;
    if (result.isSuccess) {
      try {
        enrollList = (result.data as List<dynamic>).cast<epandu_model.Enroll>();
      } catch (e) {
        enrollList = null; // Handle the case where casting fails
      }
      var getTimeTableListByIcNoresult =
          await epanduRepo.getTimeTableListByIcNo(groupId: '', startIndex: 0);

      if (getTimeTableListByIcNoresult.isSuccess) {
        try {
          timetableList = (getTimeTableListByIcNoresult.data as List<dynamic>)
              .cast<epandu_model.TimeTable>();
        } catch (e) {
          timetableList = null; // Handle the case where casting fails
        }
        if (!context.mounted) return;
        var getDTestByCodeResult =
            await epanduRepo.getDTestByCode(context: context);
        if (getDTestByCodeResult.isSuccess) {
          try {
            dtestList = (getDTestByCodeResult.data as List<dynamic>)
                .cast<epandu_model.DTest>();
          } catch (e) {
            dtestList = null;
          }
          for (var enroll in enrollList!) {
            var matchingTimeTable = timetableList!.firstWhere(
              (timeTable) => timeTable.groupId == enroll.groupId,
              orElse: () => TimeTable(
                  groupId: '',
                  startDate: '',
                  endDate: ''), // Provide a default TimeTable with empty values
            );
            var matchingDTest = dtestList!.firstWhere(
              (dTest) => dTest.groupId == enroll.groupId,
              orElse: () => DTest(
                  testDate: '',
                  groupId: ''), // Provide a default DTest with empty values
            );
            combinedList.add({
              'trandate': enroll.trandate ?? '',
              'groupId': enroll.groupId ?? '',
              'bal': (double.tryParse(enroll.feesAgree!.toString())! -
                      double.tryParse(enroll.totalPaid!.toString())!)
                  .toString()
                  .toString(),
              'totalPaid': enroll.totalPaid.toString(),
              'startDate': matchingTimeTable.startDate ?? '',
              'endDate': matchingTimeTable.endDate ?? '',
              'testDate': matchingDTest.testDate ?? '',
            });
          }
          setState(() {
            combinedList = combinedList;
            _isLoading = false;
            userName = userName;
            instituteLogoPath = instituteLogoPath;
          });
        } else {
          for (var enroll in enrollList!) {
            var matchingTimeTable = timetableList!.firstWhere(
              (timeTable) => timeTable.groupId == enroll.groupId,
              orElse: () => TimeTable(
                  groupId: '',
                  startDate: '',
                  endDate: ''), // Provide a default TimeTable with empty values
            );

            combinedList.add({
              'trandate': enroll.trandate ?? '',
              'groupId': enroll.groupId ?? '',
              'bal': (double.tryParse(enroll.feesAgree!.toString())! -
                      double.tryParse(enroll.totalPaid!.toString())!)
                  .toString()
                  .toString(),
              'startDate': matchingTimeTable.startDate ?? '',
              'endDate': matchingTimeTable.endDate ?? '',
              'testDate': ''
            });
          }

          setState(() {
            combinedList = combinedList;
            _isLoading = false;
            userName = userName;
            instituteLogoPath = instituteLogoPath;
          });
        }
      } else {
        for (var enroll in enrollList!) {
          combinedList.add({
            'trandate': enroll.trandate ?? '',
            'groupId': enroll.groupId ?? '',
            'bal': (double.tryParse(enroll.feesAgree!.toString())! -
                    double.tryParse(enroll.totalPaid!.toString())!)
                .toString()
                .toString(),
            'startDate': '',
            'endDate': '',
            'testDate': ''
          });
        }

        setState(() {
          combinedList = combinedList;
          _isLoading = false;
          userName = userName;
          instituteLogoPath = instituteLogoPath;
        });
      }
    } else {
      setState(() {
        combinedList = [];
        errorMsg = 'No Data';
        _isLoading = false;
        userName = userName;
        instituteLogoPath = instituteLogoPath;
      });
    }
  }

  _loadHistoryData() {
    if (_isLoading && combinedList.isEmpty && errorMsg == '') {
      return const Column(
        children: <Widget>[
          Expanded(
            child: SpinKitFoldingCube(
              color: Colors.blue,
            ),
          ),
        ],
      );
    } else if (!_isLoading && combinedList.isEmpty && errorMsg != '') {
      return const Center(
        child: Text(
          'No Data',
        ),
      );
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
                'NRIC :',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  width: 8.0), // Add some space between the colon and NRIC NO
              Text(
                icNo,
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
                'Name :',
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
            AppLocalizations.of(context)!.translate('enroll_class'),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildDataTable(combinedList)),
      ],
    );
  }

  Widget buildDataTable(List<Map<String, String>> combinedList) {
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
                'REG.\nDATE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            DataColumn(
              label: Text(
                'GROUP ID',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            DataColumn(
              label: Text(
                'BAL',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            DataColumn(
              label: Text(
                'NEXT \nTEST DATE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            DataColumn(
              label: Text(
                'NEXT TUTION\n DATE TIME',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
          rows: combinedList.asMap().entries.map((entry) {
            final enroll = entry.value;
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
            // double? fees1 =
            //     double.tryParse(enroll['feesAgree'].toString()) ?? 0.0;
            // double? fees2 =
            //     double.tryParse(enroll['totalPaid'].toString()) ?? 0.0;
            // double bal = fees1 - fees2;
            String startTime = '';
            String endTime = '';

            if (enroll['startDate'].toString() != '') {
              DateTime startdateTime =
                  DateTime.parse(enroll['startDate'].toString());
              startTime =
                  DateFormat('h:mm a', 'en_US').format(startdateTime.toLocal());
            }
            if (enroll['endDate'].toString() != '') {
              DateTime enddateTime =
                  DateTime.parse(enroll['endDate'].toString());
              endTime =
                  DateFormat('h:mm a', 'en_US').format(enddateTime.toLocal());
            }

            return DataRow(
              color: itemColor,
              onSelectChanged: (_) {
                createDataDialog(enroll);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Class Details'),
                      content: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //       color: Colors
                            //           .grey), // Border for the entire DataTable
                            // ),
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
                DataCell(Text(convertToDdMmYyyy(enroll['trandate'].toString())
                    .toString())),
                DataCell(Text(enroll['groupId'].toString())),
                DataCell(Text(enroll['bal'].toString())),
                enroll['testDate'].toString() != ''
                    ? DataCell(
                        Text(convertToDdMmYyyy(enroll['testDate'].toString())))
                    : const DataCell(Text('')),
                enroll['startDate'].toString() != ''
                    ? DataCell(Text(
                        '${convertToDdMmYyyy(enroll['startDate'].toString())}\n$startTime - $endTime'))
                    : const DataCell(Text('')),
                // DataCell(
                //   Text(
                //     'RM ${NumberFormat('#,##0.00').format(double.tryParse(enroll.feesAgree.toString()))}',
                //   ),
                // ),
                // DataCell(
                //   Text(
                //     'RM ${NumberFormat('#,##0.00').format(double.tryParse(enroll.totalPaid.toString()))}',
                //   ),
                // ),
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

  List<Map<String, String>> createDataDialog(Map<String, String> enroll) {
    data.clear();
    data.add({'Header': 'Group Id', 'Value': enroll['groupId'].toString()});
    data.add({'Header': 'Balance', 'Value': enroll['bal'].toString()});
    data.add({
      'Header': 'Next Test Date',
      'Value': enroll['testDate'].toString() != ''
          ? convertToDdMmYyyy(enroll['testDate'].toString())
          : ''
    });
    data.add({
      'Header': 'Next Tuition Date',
      'Value': enroll['startDate'].toString() != ''
          ? convertToDdMmYyyy(enroll['startDate'].toString())
          : ''
    });
    data.add({
      'Header': 'Red. Date',
      'Value': enroll['trandate'].toString() != ''
          ? convertToDdMmYyyy(enroll['trandate'].toString()).toString()
          : ''
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
        title: Text(
          AppLocalizations.of(context)!.translate('enrolled_class'),
        ),
      ),
      body: _loadHistoryData(),
    );
  }
}
