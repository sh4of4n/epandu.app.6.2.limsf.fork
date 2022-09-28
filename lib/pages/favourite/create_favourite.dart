import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CreateFavouritePage extends StatefulWidget {
  CreateFavouritePage({Key? key}) : super(key: key);

  @override
  State<CreateFavouritePage> createState() => _CreateFavouritePageState();
}

class _CreateFavouritePageState extends State<CreateFavouritePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> genderOptions = ['F & B', 'Supplier', 'Other'];
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Favourite'),
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
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.format_list_bulleted),
                    ),
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
                    decoration: InputDecoration(
                      labelText: 'Location Name',
                      border: OutlineInputBorder(),
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
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.description),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  // FormBuilderTextField(
                  //   name: 'position',
                  //   decoration: InputDecoration(
                  //     labelText: 'Position',
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   validator: FormBuilderValidators.compose([
                  //     FormBuilderValidators.required(),
                  //   ]),
                  //   readOnly: true,
                  //   onTap: () async {
                  //     final result =
                  //         await context.router.push(FavourieMapRoute());
                  //     if (result != null) {
                  //       _formKey.currentState!.fields['position']!
                  //           .didChange(result.toString());
                  //       MarkerId a = MarkerId('value');
                  //       setState(() {
                  //         markers[a] = Marker(
                  //           markerId: const MarkerId('value'),
                  //           position: result as LatLng,
                  //           icon: BitmapDescriptor.defaultMarker,
                  //         );
                  //       });
                  //       mapController!.moveCamera(
                  //         CameraUpdate.newLatLng(
                  //           result as LatLng,
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),

                  SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'add1',
                    decoration: InputDecoration(
                      labelText: 'Address 1',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.place),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'add2',
                    decoration: InputDecoration(
                      labelText: 'Address 2',
                      border: OutlineInputBorder(),
                      icon: Icon(null),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'state',
                    decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                      icon: Icon(null),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'city',
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                      icon: Icon(null),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'postcode',
                    decoration: InputDecoration(
                      labelText: 'Postcode',
                      border: OutlineInputBorder(),
                      icon: Icon(null),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  SizedBox(
                    height: 8,
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
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(-33.852, 151.211), zoom: 11.0),
                        markers: Set<Marker>.of(markers.values),
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        onTap: (pos) async {
                          final result =
                              await context.router.push(FavourieMapRoute());
                          if (result != null) {
                            MarkerId a = MarkerId('value');
                            setState(() {
                              markers[a] = Marker(
                                markerId: const MarkerId('value'),
                                position: result as LatLng,
                                icon: BitmapDescriptor.defaultMarker,
                              );
                            });
                            mapController!.moveCamera(
                              CameraUpdate.newLatLng(
                                result as LatLng,
                              ),
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
                    children: List.generate(_imageFileList.length + 1, (index) {
                      return index == 0
                          ? GestureDetector(
                              onTap: () async {
                                List<XFile>? pickedFile =
                                    await _picker.pickMultiImage();
                                if (pickedFile != null) {
                                  setState(() {
                                    _imageFileList.addAll(pickedFile);
                                  });
                                }
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 1,
                                child: Container(
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
    );
  }
}
