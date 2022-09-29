import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class EditFavouritePlacePage extends StatefulWidget {
  const EditFavouritePlacePage({super.key});

  @override
  State<EditFavouritePlacePage> createState() => _EditFavouritePlacePageState();
}

class _EditFavouritePlacePageState extends State<EditFavouritePlacePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> genderOptions = ['Cafe', 'Supplier', 'Other'];
  late GoogleMapController mapController;
  double _lat = 5.244208533751952;
  double _lng = 100.43825519887051;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<XFile> _imageFileList = [];
  final ImagePicker _picker = ImagePicker();

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

  Future<File> _fileFromImageUrl() async {
    final response = await http.get(Uri.parse(
        'https://3u8dbs16f2emlqxkbc8tbvgf-wpengine.netdna-ssl.com/wp-content/uploads/2019/06/Coffee-bean-Tea-Leaf-Logo-Cups.jpg'));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(p.join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);
    if (mounted) {
      setState(() {
        _imageFileList.add(XFile(file.path));
      });
    }

    EasyLoading.dismiss();
    return file;
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show();

    _fileFromImageUrl();
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
          title: Text('Edit Favourite Place'),
          actions: [
            IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderDropdown<String>(
                      name: 'type',
                      decoration: InputDecoration(
                        labelText: 'Type',
                        icon: Icon(Icons.format_list_bulleted),
                        filled: true,
                      ),
                      initialValue: 'Cafe',
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: genderOptions
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
                    FormBuilderTextField(
                      name: 'name',
                      initialValue: 'The Coffee Bean & Tea Leaf',
                      decoration: InputDecoration(
                        labelText: 'Location Name',
                        filled: true,
                        icon: Icon(Icons.map),
                      ),
                      onChanged: (val) {},
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FormBuilderTextField(
                      name: 'description',
                      initialValue:
                          'Born and brewed in Southern California since 1963, The Coffee Bean & Tea Leaf® is passionate about connecting loyal customers with carefully handcrafted',
                      decoration: InputDecoration(
                        labelText: 'Description',
                        filled: true,
                        icon: Icon(Icons.description),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 2,
                    ),

                    SizedBox(
                      height: 16.0,
                    ),

                    Text(
                      'Position',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            setState(() {
                              mapController = controller;
                            });
                            setLocationOnMap(
                                5.244208533751952, 100.43825519887051);
                          },
                          initialCameraPosition: CameraPosition(
                              target: LatLng(_lat, _lng), zoom: 11.0),
                          markers: Set<Marker>.of(markers.values),
                          scrollGesturesEnabled: false,
                          zoomGesturesEnabled: false,
                          zoomControlsEnabled: false,
                          onTap: (pos) async {
                            final result =
                                await context.router.push(FavourieMapRoute(
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
                    SizedBox(
                      height: 8,
                    ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: () async {
                    //       List<XFile>? pickedFile =
                    //           await _picker.pickMultiImage();
                    //       if (pickedFile != null) {
                    //         setState(() {
                    //           _imageFileList.addAll(pickedFile);
                    //         });
                    //       }
                    //     },
                    //     child: Text('+ Add Photos'),
                    //   ),
                    // ),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children:
                          List.generate(_imageFileList.length + 1, (index) {
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

                                                context.router.pop();
                                              },
                                              child: const Text('Take photo'),
                                            ),
                                            SimpleDialogOption(
                                              onPressed: () async {
                                                List<XFile>? pickedFile =
                                                    await _picker
                                                        .pickMultiImage();
                                                if (pickedFile != null) {
                                                  setState(() {
                                                    _imageFileList
                                                        .addAll(pickedFile);
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
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  Container(
                                    height: 200,
                                    width: 200,
                                    child: Image.file(
                                      File(
                                        _imageFileList[index - 1].path,
                                      ),
                                      fit: BoxFit.cover,
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
                                        child: Icon(Icons.close),
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
      ),
    );
  }
}
