import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/expenses_model.dart';
import 'package:epandu/common_library/services/repository/expenses_repository.dart';
import 'package:epandu/router.gr.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ExpFuelListPage extends StatefulWidget {
  ExpFuelListPage({Key? key}) : super(key: key);

  @override
  State<ExpFuelListPage> createState() => _ExpFuelListPageState();
}

class _ExpFuelListPageState extends State<ExpFuelListPage> {
  GlobalKey<RefreshIndicatorState> _refresherKey =
      GlobalKey<RefreshIndicatorState>();
  final ExpensesRepo expensesRepo = ExpensesRepo();
  Future? expFuelFuture;
  NumberFormat formatter = NumberFormat.currency(locale: 'ms_MY', symbol: 'RM');

  Future getExpFuel() async {
    var result = await expensesRepo.getExp(
      expId: '',
      type: '',
      expStartDateString: '',
      expEndDateString: '',
      startIndex: 0,
      noOfRecords: 100,
    );
    return result;
  }

  Future deleteExpFuel({
    required fuels,
    required fuelIndex,
  }) async {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    var result = await expensesRepo.deleteExp(
      expId: fuels[fuelIndex].expId,
    );
    setState(() {
      fuels.removeWhere((item) => item.expId == fuels[fuelIndex].expId);
    });
    EasyLoading.dismiss();
    return result;
  }

  @override
  void initState() {
    super.initState();
    expFuelFuture = getExpFuel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        EasyLoading.dismiss();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Fuel Expenses'),
          actions: [
            IconButton(
              onPressed: () async {
                var result = await context.router.push(CreateFuelRoute());
                if (result.toString() == 'refresh') {
                  setState(() {
                    expFuelFuture = getExpFuel();
                  });
                }
              },
              icon: Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          key: _refresherKey,
          onRefresh: () async {
            setState(() {
              expFuelFuture = getExpFuel();
            });
          },
          child: FutureBuilder(
            future: expFuelFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                case ConnectionState.active:
                  return Center(child: const CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data.data.length == 0) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/undraw_void_-3-ggu.svg',
                              semanticsLabel: 'Acme Logo',
                              width: 200,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              'No Expenses',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ExpandableTheme(
                      data: const ExpandableThemeData(
                        iconColor: Colors.blue,
                        useInkWell: true,
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        itemCount: snapshot.data.data.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return ExpandableNotifier(
                            child: ScrollOnExpand(
                              scrollOnExpand: true,
                              scrollOnCollapse: false,
                              child: Container(
                                color: Color(0xFFFFFFFF),
                                child: ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                    hasIcon: false,
                                    headerAlignment:
                                        ExpandablePanelHeaderAlignment.center,
                                    tapBodyToCollapse: true,
                                  ),
                                  header: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.today,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  '${DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data.data[index].expDatetime))}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              formatter.format(
                                                double.parse(
                                                  snapshot
                                                      .data.data[index].amount,
                                                ),
                                              ),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.pin),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '${snapshot.data.data[index].mileage} km',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.format_list_bulleted),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              snapshot.data.data[index].type,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.description),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Flexible(
                                              child: Text(
                                                snapshot.data.data[index]
                                                    .description,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  collapsed: SizedBox(),
                                  expanded: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                true, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Delete Fuel Expenses'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: const <Widget>[
                                                      Text(
                                                          'Are you sure want to delete?'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Ok'),
                                                    onPressed: () async {
                                                      await context.router
                                                          .pop();
                                                      deleteExpFuel(
                                                        fuels:
                                                            snapshot.data.data,
                                                        fuelIndex: index,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          var result = await context.router
                                              .push(EditExpFuelRoute(
                                                  fuel: snapshot
                                                      .data.data[index]));
                                          if (result != null) {
                                            var resultFuel = Exp.fromJson(
                                                jsonDecode(jsonEncode(result)));
                                            setState(() {
                                              snapshot.data.data[index].type =
                                                  resultFuel.type;
                                              snapshot.data.data[index]
                                                      .expDatetime =
                                                  resultFuel.expDatetime;
                                              snapshot.data.data[index]
                                                  .mileage = resultFuel.mileage;
                                              snapshot.data.data[index].amount =
                                                  resultFuel.amount;
                                              snapshot.data.data[index].lat =
                                                  resultFuel.lat;
                                              snapshot.data.data[index].lng =
                                                  resultFuel.lng;
                                              snapshot.data.data[index]
                                                      .description =
                                                  resultFuel.description;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                        ),
                                      ),
                                    ],
                                  ),
                                  builder: (_, collapsed, expanded) {
                                    return Expandable(
                                      collapsed: collapsed,
                                      expanded: expanded,
                                      theme: const ExpandableThemeData(
                                        crossFadePoint: 0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(child: const CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
