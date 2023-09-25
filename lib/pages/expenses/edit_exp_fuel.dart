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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

@RoutePage()
class EditExpFuelPage extends StatefulWidget {
  final fuel;
  const EditExpFuelPage({Key? key, required this.fuel}) : super(key: key);

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

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);
  final List<Map<String, dynamic>> _imageFileList = [];
  final ImagePicker _picker = ImagePicker();

  Future updateExpFuel() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
      );
      _formKey.currentState?.fields['date']?.value;
      var result = await expensesRepo.updateExp(
        expId: widget.fuel.expId,
        expDatetimeString:
            '${DateFormat('yyyy-MM-dd').format(_formKey.currentState?.fields['date']?.value)} ${DateFormat('HH:mm:ss').format(_formKey.currentState?.fields['time']?.value)}',
        type: _formKey.currentState?.fields['type']?.value,
        description: _formKey.currentState?.fields['description']?.value,
        mileage: _formKey.currentState?.fields['mileage']?.value,
        amount: _formKey.currentState?.fields['amount']?.value,
        lat: _lat,
        lng: _lng,
      );
      EasyLoading.dismiss();
      if (result.isSuccess) {
        if (_imageFileList.isNotEmpty) {
          Iterable<Future> a = [];
          List<Future> b = [];
          for (var element in _imageFileList) {
            if (element['fileKey'] == 'new') {
              b.add(expensesRepo.saveExpPicture(
                expId: result.data[0].expId,
                base64Code:
                    base64Encode(File(element['file'].path).readAsBytesSync()),
              ));
            }
            if (element['file'] == null) {
              b.add(
                expensesRepo.removeExpPicture(
                  expId: result.data[0].expId,
                  fileKey: element['fileKey'],
                ),
              );
            }
          }
          a = b;
          EasyLoading.show(
            maskType: EasyLoadingMaskType.black,
          );
          Future<List> c = Future.wait(a);
          await c;
          EasyLoading.dismiss();
        }
      }

      context.router.pop(result.data[0]);
    }
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

  Future<void> _getCurrentPosition() async {
    setLocationOnMap(_lat, _lng);
  }

  Future getExpPicture() async {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    var result = await expensesRepo.getExpPicture(
      expId: widget.fuel.expId,
      bgnLimit: 0,
      endLimit: 100,
    );

    if (result.isSuccess && result.data != null) {
      for (var element in result.data) {
        final response = await http.get(
          Uri.parse(
            element.picturePath.replaceAll(removeBracket, '').split('\r\n')[0],
          ),
        );

        final documentDirectory = await getApplicationDocumentsDirectory();

        final file = File(p.join(
            documentDirectory.path,
            element.key +
                p.extension(element.picturePath
                    .replaceAll(removeBracket, '')
                    .split('\r\n')[0])));

        file.writeAsBytesSync(response.bodyBytes);
        if (mounted) {
          setState(() {
            _imageFileList
                .add({'fileKey': element.key, 'file': XFile(file.path)});
          });
        }
      }
    }
    await EasyLoading.dismiss();
    return result;
  }

  @override
  void initState() {
    super.initState();
    _lat = double.parse(widget.fuel.lat);
    _lng = double.parse(widget.fuel.lng);

    getExpPicture();
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
          title: const Text('Edit Expenses'),
          actions: [
            IconButton(
              onPressed: () {
                updateExpFuel();
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
                          initialValue: DateTime.parse(
                            widget.fuel.expDatetime,
                          ),
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
                          initialValue: DateTime.parse(
                            widget.fuel.expDatetime,
                          ).toLocal(),
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
                    initialValue: widget.fuel.mileage,
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
                    initialValue: widget.fuel.type,
                    decoration: const InputDecoration(
                      labelText: 'Fuel Type',
                      filled: true,
                      icon: Icon(Icons.local_gas_station),
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FormBuilderTextField(
                    name: 'description',
                    initialValue: widget.fuel.description,
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
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'amount',
                    initialValue: widget.fuel.amount,
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
                        } catch (e) {}
                        return oldValue;
                      }),
                    ],
                  ),
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
                    height: 8,
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(
                        _imageFileList
                                .where((element) => element['file'] != null)
                                .toList()
                                .length +
                            1, (index) {
                      List<Map<String, dynamic>> leftImage = _imageFileList
                          .where((element) => element['file'] != null)
                          .toList();
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
                                                  _imageFileList.add({
                                                    'fileKey': 'new',
                                                    'file': photo
                                                  });
                                                });
                                              }

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
                                                  for (XFile element
                                                      in pickedFile) {
                                                    _imageFileList.add({
                                                      'fileKey': 'new',
                                                      'file': element
                                                    });
                                                  }
                                                });
                                              }
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
                                      gallery.add(File(element['file'].path));
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
                                        leftImage[index - 1]['file'].path,
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
                                        // _imageFileList
                                        //     .removeAt(index - 1);
                                        // removeFavPlacePicture(placeId: wid, fileKey: fileKey)
                                        if (leftImage[index - 1]['fileKey'] ==
                                            'new') {
                                          leftImage.removeAt(index - 1);
                                        } else {
                                          leftImage[index - 1]['file'] = null;
                                        }
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
