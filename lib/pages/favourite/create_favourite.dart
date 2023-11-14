import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:epandu/common_library/services/repository/favourite_repository.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CreateFavouritePage extends StatefulWidget {
  const CreateFavouritePage({Key? key}) : super(key: key);

  @override
  State<CreateFavouritePage> createState() => _CreateFavouritePageState();
}

class _CreateFavouritePageState extends State<CreateFavouritePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> genderOptions = ['Cafe', 'Supplier', 'Other'];
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageFileList = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late GoogleMapController mapController;
  double _lat = 3.139003;
  double _lng = 101.68685499999992;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final favouriteRepo = FavouriteRepo();

  @override
  void initState() {
    super.initState();
  }

  Future saveFavPlace() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
      );
      var result = await favouriteRepo.saveFavPlace(
        type: _formKey.currentState?.fields['type']?.value,
        name: _formKey.currentState?.fields['name']?.value,
        description: _formKey.currentState?.fields['description']?.value,
        lat: _lat,
        lng: _lng,
      );
      if (result.isSuccess) {
        if (_imageFileList.isNotEmpty) {
          Iterable<Future> a = [];
          List<Future> b = [];
          for (XFile element in _imageFileList) {
            b.add(favouriteRepo.saveFavPlacePicture(
              placeId: result.data[0].placeId,
              base64Code: base64Encode(File(element.path).readAsBytesSync()),
            ));
          }
          a = b;
          Future<List> c = Future.wait(a);
          await c;
        } else {}
      }
      EasyLoading.dismiss();
      if (!context.mounted) return;
      context.router.pop('refresh');
    }
  }

  Future<void> _getCurrentPosition() async {
    // final hasPermission = await _handlePermission();

    // if (!hasPermission) {
    //   return;
    // }

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
          title: const Text('Create Favourite Place'),
          actions: [
            IconButton(
                onPressed: () {
                  saveFavPlace();
                },
                icon: const Icon(Icons.save))
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
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        icon: Icon(Icons.format_list_bulleted),
                        filled: true,
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
                    const SizedBox(
                      height: 16,
                    ),
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(
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
                    const SizedBox(
                      height: 16,
                    ),
                    FormBuilderTextField(
                      name: 'description',
                      decoration: const InputDecoration(
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

                    const SizedBox(
                      height: 16.0,
                    ),

                    const Text(
                      'Position',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                    const SizedBox(
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
                      physics: const NeverScrollableScrollPhysics(),
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
                                  GestureDetector(
                                    onTap: () {
                                      List gallery = [];
                                      for (var element in _imageFileList) {
                                        gallery.add(File(element.path));
                                      }

                                      context.router.push(
                                        PhotoViewRoute(
                                          title: 'Favourite Place',
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
      ),
    );
  }
}
