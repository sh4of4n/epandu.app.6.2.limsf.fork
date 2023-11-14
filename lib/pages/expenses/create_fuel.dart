import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:epandu/common_library/services/repository/expenses_repository.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

@RoutePage()
class CreateFuelPage extends StatefulWidget {
  const CreateFuelPage({Key? key}) : super(key: key);

  @override
  State<CreateFuelPage> createState() => _CreateFuelPageState();
}

class _CreateFuelPageState extends State<CreateFuelPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  late GoogleMapController mapController;
  double _lat = 3.139003;
  double _lng = 101.68685499999992;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final expensesRepo = ExpensesRepo();
  final List<XFile> _imageFileList = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _getCurrentPosition() async {
    Position position = await _geolocatorPlatform.getCurrentPosition();
    setLocationOnMap(position.latitude, position.longitude);
  }

  void setLocationOnMap(double lat, double lng) {
    mapController.moveCamera(
      CameraUpdate.newLatLng(
        LatLng(lat, lng),
      ),
    );
    MarkerId a = const MarkerId('value');
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

  Future saveExpFuel() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
      );
      var result = await expensesRepo.saveExp(
        expDatetimeString:
            '${DateFormat('yyyy-MM-dd').format(_formKey.currentState?.fields['date']?.value)} ${DateFormat('HH:mm:ss').format(_formKey.currentState?.fields['time']?.value)}',
        type: _formKey.currentState?.fields['type']?.value,
        description: _formKey.currentState?.fields['description']?.value,
        mileage: _formKey.currentState?.fields['mileage']?.value,
        amount: _formKey.currentState?.fields['amount']?.value,
        lat: _lat,
        lng: _lng,
      );
      await EasyLoading.dismiss();
      if (result.isSuccess) {
        if (_imageFileList.isNotEmpty) {
          Iterable<Future> a = [];
          List<Future> b = [];
          for (XFile element in _imageFileList) {
            b.add(expensesRepo.saveExpPicture(
              expId: result.data[0].expId,
              base64Code: base64Encode(File(element.path).readAsBytesSync()),
            ));
          }
          a = b;
          EasyLoading.show(
            maskType: EasyLoadingMaskType.black,
          );
          Future<List> c = Future.wait(a);
          await c;
          await EasyLoading.dismiss();
        } else {}
      }
      if (!context.mounted) return;
      context.router.pop('refresh');
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        EasyLoading.dismiss();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffd225),
          title: const Text('Expenses'),
          actions: [
            IconButton(
              onPressed: () {
                saveExpFuel();
              },
              icon: const Icon(Icons.done),
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
                          initialValue: DateTime.now(),
                          inputType: InputType.date,
                          decoration: const InputDecoration(
                              labelText: 'Date',
                              filled: true,
                              icon: Icon(Icons.calendar_today)),
                          format: DateFormat('dd/MM/yyyy'),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 4,
                        child: FormBuilderDateTimePicker(
                          name: 'time',
                          initialEntryMode: DatePickerEntryMode.input,
                          initialValue: DateTime.now(),
                          inputType: InputType.time,
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FormBuilderTextField(
                    name: 'mileage',
                    decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 16,
                  ),
                  FormBuilderDropdown<String>(
                    name: 'type',
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      filled: true,
                      icon: Icon(Icons.format_list_bulleted),
                    ),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: ['Fuel', 'Tayar', 'Service', 'Others']
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (_formKey.currentState!.fields['description']!.value
                              .toString()
                              .isEmpty ||
                          _formKey.currentState!.fields['description']!.value ==
                              null) {
                        _formKey.currentState?.fields['description']
                            ?.didChange(value);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FormBuilderTextField(
                    name: 'description',
                    decoration: InputDecoration(
                      labelText: 'Description',
                      filled: true,
                      icon: const Icon(Icons.description),
                      suffix: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _formKey.currentState!.fields['description']?.reset();
                        },
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 2,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FormBuilderTextField(
                    name: 'amount',
                    decoration: const InputDecoration(
                      labelText: 'Amount',
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
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {
                          print(e.toString());
                        }
                        return oldValue;
                      }),
                    ],
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 16,
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(_imageFileList.length + 1, (index) {
                      return index == 0
                          ? GestureDetector(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                        title: const Text('Add photos'),
                                        children: <Widget>[
                                          SimpleDialogOption(
                                            onPressed: () async {
                                              final XFile? photo =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (photo != null) {
                                                setState(() {
                                                  _imageFileList.add(photo);
                                                });
                                              }
                                              if (!context.mounted) return;
                                              context.router.pop();
                                            },
                                            child: const Text('Take photo'),
                                          ),
                                          SimpleDialogOption(
                                            onPressed: () async {
                                              List<XFile>? pickedFile =
                                                  await _picker
                                                      .pickMultiImage();
                                              if (pickedFile.isNotEmpty) {
                                                setState(() {
                                                  _imageFileList
                                                      .addAll(pickedFile);
                                                });
                                              }
                                              if (!context.mounted) return;
                                              context.router.pop();
                                            },
                                            child: const Text(
                                                'Choose existing photo'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 1,
                                child: const SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image),
                                      Text('Add photos'),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    List gallery = [];
                                    for (var element in _imageFileList) {
                                      gallery.add(File(element.path));
                                    }

                                    context.router.push(
                                      PhotoViewRoute(
                                        title: 'Expenses',
                                        url: gallery,
                                        initialIndex: index - 1,
                                        type: 'file',
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.file(
                                      File(
                                        _imageFileList[index - 1].path,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 4,
                                  top: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _imageFileList.removeAt(index - 1);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                ),
                              ],
                            );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
