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
    var result = await expensesRepo.getExpFuel(
      fuelId: '',
      type: '',
      fuelStartDateString: '',
      fuelEndDateString: '',
      startIndex: 0,
      noOfRecords: 100,
    );
    return result;
  }

  Future deleteExpFuel({
    required fuels,
    required fuelIndex,
  }) async {
    EasyLoading.show();
    var result = await expensesRepo.deleteExpFuel(
      fuelId: fuels[fuelIndex].fuelId,
    );
    setState(() {
      fuels.removeWhere((item) => item.fuelId == fuels[fuelIndex].fuelId);
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
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Expenses Fuel'),
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
                            'You haven\'t refueled',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: snapshot.data.data.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 8,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${snapshot.data.data[index].fuelType} (${snapshot.data.data[index].liter} L)'),
                                    Text(
                                        '${DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data.data[index].fuelDatetime))}'),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${snapshot.data.data[index].mileage} km'),
                                    Text(
                                      formatter.format(
                                        double.parse(
                                          snapshot.data.data[index].totalAmount,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
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
                                  deleteExpFuel(
                                    fuels: snapshot.data.data,
                                    fuelIndex: index,
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  var result = await context.router.push(
                                      EditExpFuelRoute(
                                          fuel: snapshot.data.data[index]));
                                  if (result != null) {
                                    var resultFuel = ExpFuel.fromJson(
                                        jsonDecode(jsonEncode(result)));
                                    setState(() {
                                      snapshot.data.data[index].fuelType =
                                          resultFuel.fuelType;
                                      snapshot.data.data[index].fuelDatetime =
                                          resultFuel.fuelDatetime;
                                      snapshot.data.data[index].mileage =
                                          resultFuel.mileage;
                                      snapshot.data.data[index].totalAmount =
                                          resultFuel.totalAmount;
                                      snapshot.data.data[index].lat =
                                          resultFuel.lat;
                                      snapshot.data.data[index].lng =
                                          resultFuel.lng;
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
                              theme:
                                  const ExpandableThemeData(crossFadePoint: 0),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
