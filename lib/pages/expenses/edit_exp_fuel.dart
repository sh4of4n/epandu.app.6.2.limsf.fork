import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/expenses_repository.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EditExpFuelPage extends StatefulWidget {
  final fuel;
  EditExpFuelPage({Key? key, required this.fuel}) : super(key: key);

  @override
  State<EditExpFuelPage> createState() => _EditExpFuelPageState();
}

class _EditExpFuelPageState extends State<EditExpFuelPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final expensesRepo = ExpensesRepo();
  double _lat = 3.139003;
  double _lng = 101.68685499999992;
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future updateExpFuel() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      EasyLoading.show();
      _formKey.currentState?.fields['date']?.value;
      var result = await expensesRepo.updateExpFuel(
        fuelId: widget.fuel.fuelId,
        fuelDatetime:
            '${DateFormat('yyyy-MM-dd').format(_formKey.currentState?.fields['date']?.value)} ${DateFormat('HH:mm:ss').format(_formKey.currentState?.fields['time']?.value)}',
        fuelType: _formKey.currentState?.fields['fuelType']?.value,
        liter: _formKey.currentState?.fields['liter']?.value,
        mileage: _formKey.currentState?.fields['mileage']?.value,
        priceLiter: _formKey.currentState?.fields['priceLiter']?.value,
        totalAmount: _formKey.currentState?.fields['totalAmount']?.value,
        lat: _lat,
        lng: _lng,
      );
      if (result.isSuccess) {}
      EasyLoading.dismiss();
      context.router.pop(result.data[0]);
    }
  }

  void calculatePrice(int priority) {
    double priceLiter =
        double.parse(_formKey.currentState?.fields['priceLiter']?.value ?? '0');

    double totalAmount = double.parse(
        _formKey.currentState?.fields['totalAmount']?.value ?? '0');

    double liter =
        double.parse(_formKey.currentState?.fields['liter']?.value ?? '0');

    if (priceLiter > 0 && totalAmount > 0 && (priority == 1 || priority == 2)) {
      _formKey.currentState?.fields['liter']
          ?.didChange((totalAmount / priceLiter).toStringAsFixed(2));
      return;
    }

    if (priceLiter > 0 && liter > 0 && priority == 3) {
      _formKey.currentState?.fields['totalAmount']
          ?.didChange((priceLiter * liter).toStringAsFixed(2));
      return;
    }

    if (totalAmount > 0 && liter > 0) {
      _formKey.currentState?.fields['priceLiter']
          ?.didChange((totalAmount / liter).toStringAsFixed(2));
      return;
    }
  }

  void setLocationOnMap(double lat, double lng) {
    mapController.moveCamera(
      CameraUpdate.newLatLng(
        LatLng(lat, lng),
      ),
    );
    MarkerId a = MarkerId('value');
    setState(() {
      _lat = lat;
      _lng = lng;
      markers[a] = Marker(
        markerId: const MarkerId('value'),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarker,
      );
    });
  }

  Future<void> _getCurrentPosition() async {
    setLocationOnMap(widget.fuel.lat, widget.fuel.lng);
  }

  @override
  void initState() {
    super.initState();
    _lat = double.parse(widget.fuel.lat);
    _lng = double.parse(widget.fuel.lng);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        EasyLoading.dismiss();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffffd225),
          title: Text('Edit Expenses Fuel'),
          actions: [
            IconButton(
              onPressed: () {
                updateExpFuel();
              },
              icon: Icon(Icons.done),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: FormBuilderDateTimePicker(
                          name: 'date',
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialValue: DateTime.parse(
                            widget.fuel.fuelDatetime,
                          ),
                          inputType: InputType.date,
                          decoration: InputDecoration(
                              labelText: 'Date',
                              filled: true,
                              icon: Icon(Icons.calendar_today)),
                          format: DateFormat('dd/MM/yyyy'),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 4,
                        child: FormBuilderDateTimePicker(
                          name: 'time',
                          initialEntryMode: DatePickerEntryMode.input,
                          initialValue: DateTime.parse(
                            widget.fuel.fuelDatetime,
                          ).toLocal(),
                          inputType: InputType.time,
                          decoration: InputDecoration(
                            labelText: 'Time',
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FormBuilderTextField(
                    name: 'mileage',
                    initialValue: widget.fuel.mileage,
                    decoration: InputDecoration(
                      labelText: 'Mileage',
                      filled: true,
                      icon: Icon(Icons.onetwothree),
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ],
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FormBuilderDropdown<String>(
                    name: 'fuelType',
                    initialValue: widget.fuel.fuelType,
                    decoration: InputDecoration(
                      labelText: 'Fuel Type',
                      filled: true,
                      icon: Icon(Icons.local_gas_station),
                    ),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: ['RON95', 'RON97', 'Diesel']
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Focus(
                          onFocusChange: (value) {
                            if (!value) calculatePrice(1);
                          },
                          child: FormBuilderTextField(
                            name: 'priceLiter',
                            initialValue: widget.fuel.priceLiter,
                            decoration: InputDecoration(
                              labelText: 'Price/L',
                              filled: true,
                              icon: Icon(Icons.attach_money),
                            ),
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                              ],
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: Focus(
                          onFocusChange: (value) {
                            if (!value) calculatePrice(2);
                          },
                          child: FormBuilderTextField(
                            name: 'totalAmount',
                            initialValue: widget.fuel.totalAmount,
                            decoration: InputDecoration(
                              labelText: 'Total Amount',
                              filled: true,
                            ),
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                              ],
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: Focus(
                          onFocusChange: (value) {
                            if (!value) calculatePrice(3);
                          },
                          child: FormBuilderTextField(
                            name: 'liter',
                            initialValue: widget.fuel.liter,
                            decoration: InputDecoration(
                                labelText: 'Liter',
                                filled: true,
                                suffix: Text('L')),
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                              ],
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 16.0,
                  // ),
                  // FormBuilderTextField(
                  //   name: 'petrol_station',
                  //   decoration: InputDecoration(
                  //     labelText: 'Petrol Station',
                  //     filled: true,
                  //     icon: Icon(Icons.location_on),
                  //   ),
                  //   validator: FormBuilderValidators.compose(
                  //     [
                  //       FormBuilderValidators.required(),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            mapController = controller;
                          });
                          _getCurrentPosition();
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(_lat, _lng), zoom: 21.0),
                        markers: Set<Marker>.of(markers.values),
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                        onTap: (pos) async {
                          final result = await context.router.push(FuelMapRoute(
                            lat: _lat,
                            lng: _lng,
                          ));
                          if (result != null) {
                            setLocationOnMap(
                              (result as LatLng).latitude,
                              result.longitude,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
