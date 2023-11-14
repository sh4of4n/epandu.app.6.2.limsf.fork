import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common_library/services/model/epandu_model.dart' as epandu_model;
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/local_storage.dart';

@RoutePage(name: 'paymentList')
class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  double _total = 0;
  final List<Map<String, String>> data = [];
  final epanduRepo = EpanduRepo();
  final authRepo = AuthRepo();
  var _paymentHistoryData;
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
    var result = await epanduRepo.getCollectionByStudent(context: context);

    if (result.isSuccess) {
      setState(() {
        _paymentHistoryData = result.data;
      });
    } else {
      setState(() {
        _paymentHistoryData = result.message;
      });
    }

    setState(() {
      _isLoading = false;
      userName = userName;
      instituteLogoPath = instituteLogoPath;
    });
  }

  _loadHistoryData() {
    if (_isLoading && _paymentHistoryData == null) {
      return const Column(
        children: <Widget>[
          Expanded(
            child: SpinKitFoldingCube(
              color: Colors.blue,
            ),
          ),
        ],
      );
    } else if (!_isLoading && _paymentHistoryData is String) {
      return Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                _paymentHistoryData,
              ),
            ),
          ),
        ],
      );
    }
    List<epandu_model.CollectTrn>? paymentHistoryList;
    try {
      paymentHistoryList = (_paymentHistoryData as List<dynamic>)
          .cast<epandu_model.CollectTrn>();
    } catch (e) {
      paymentHistoryList = null; // Handle the case where casting fails
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
                _paymentHistoryData[0].icNo ?? '',
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
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Payments',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildDataTable(paymentHistoryList),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Align text to the right
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _getTotal(paymentHistoryList!),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                            textAlign: TextAlign
                                .start, // Optional, align text to the right
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget buildDataTable(List<epandu_model.CollectTrn>? paymentHistoryList) {
    if (paymentHistoryList == null || paymentHistoryList.isEmpty) {
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
                'RECEIPT\nNO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'TRAN.\nDATE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'PAYMENT\nAMOUNT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'TRANS.\nAMOUNT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'BAL.\nAMOUNT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: paymentHistoryList.asMap().entries.map((entry) {
            final payments = entry.value;
            final index = entry.key;
            final isEvenIndex = index % 2 == 0;
            _total += double.tryParse(
                paymentHistoryList[index].payAmount.toString())!;

            // double? payAmount =
            //     double.tryParse(payments.payAmount.toString()) ?? 0.0;
            // double? tranTotal =
            //     double.tryParse(payments.tranTotal.toString()) ?? 0.0;
            // double bal = payAmount - tranTotal;

            //int lastKey = paymentHistoryList.asMap().entries.last.key;
            final itemColor = MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
                if (isEvenIndex) {
                  return Colors.grey[200]!; // Color when the cell is pressed
                }
                return Colors.white; // Default color
              },
            );
            return DataRow(
              color: itemColor,
              onSelectChanged: (_) {
                createDataDialog(
                    payments.recpNo.toString(),
                    convertToDdMmYyyy(payments.trandate.toString()),
                    'RM ${NumberFormat('#,##0.00').format(double.tryParse(payments.payAmount.toString()))}',
                    'RM ${NumberFormat('#,##0.00').format(double.tryParse(payments.tranTotal.toString()))}',
                    'RM ${NumberFormat('#,##0.00').format(double.tryParse(payments.balAmount.toString()))}');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Payment Details'),
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
                DataCell(Text(payments.recpNo.toString())),
                DataCell(Text(convertToDdMmYyyy(payments.trandate.toString()))),
                DataCell(Text(
                    'RM ${NumberFormat('#,##0.00').format(double.tryParse(payments.payAmount.toString()))}')),
                DataCell(Text(
                    'RM ${NumberFormat('#,##0.00').format(double.tryParse(payments.tranTotal.toString()))}')),
                DataCell(Text(
                    'RM ${NumberFormat('#,##0.00').format(double.tryParse(payments.balAmount.toString().replaceAll('-', '')))}')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getTotal(paymentHistoryList) {
    _total = 0;
    for (int i = 0; i < paymentHistoryList.length; i += 1) {
      _total += double.tryParse(paymentHistoryList[i].payAmount)!;
    }
    return 'Total Payment Amount: RM ${NumberFormat('#,##0.00').format(double.tryParse(_total.toString()))}';
  }

  String convertToDdMmYyyy(String input) {
    DateTime dateTime = DateTime.parse(input);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  List<Map<String, String>> createDataDialog(String? receiptNo, String? date,
      String? amount, String tranTotal, String balAmount) {
    data.clear();
    data.add({
      'Header': 'Receipt No',
      'Value': receiptNo != null ? receiptNo.toString() : ''
    });
    data.add({'Header': 'Date', 'Value': date != null ? date.toString() : ''});
    data.add({
      'Header': 'Payment Amount',
      'Value': amount != null ? amount.toString() : ''
    });
    data.add({'Header': 'Tran. Amount', 'Value': tranTotal.toString()});
    data.add({'Header': 'Balance Amount', 'Value': balAmount.toString()});
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
          'PAYMENT LIST',
        ),
      ),
      body: _loadHistoryData(),
    );
  }
}
