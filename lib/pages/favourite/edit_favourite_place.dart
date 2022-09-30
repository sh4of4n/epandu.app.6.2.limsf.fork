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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class EditFavouritePlacePage extends StatefulWidget {
  final String placeId;
  const EditFavouritePlacePage({
    super.key,
    required this.placeId,
  });

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
  final favouriteRepo = FavouriteRepo();
  Future? favPlaceFuture;

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  Future getFavPlace() async {
    var result = await favouriteRepo.getFavPlace(
        placeId: widget.placeId, type: '', name: '', description: '');
    if (result.isSuccess && result.data != null) {
      for (var element in result.data) {}
    }
    return result;
  }

  Future updateFavPlace() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      EasyLoading.show();
      var result = await favouriteRepo.updateFavPlace(
          type: _formKey.currentState?.fields['type']?.value,
          name: _formKey.currentState?.fields['name']?.value,
          description: _formKey.currentState?.fields['description']?.value,
          lat: _lat,
          lng: _lng,
          placeId: widget.placeId);
      if (result.isSuccess) {
        if (_imageFileList.length > 0) {
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
      context.router.pop('refresh');
    }
  }

  Future getFavPlacePicture({
    required String placeId,
  }) async {
    var result = await favouriteRepo.getFavPlacePicture(
      placeId: placeId,
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
            p.extension(
                element.picturePath
                    .replaceAll(removeBracket, '')
                    .split('\r\n')[0],
                2)));

        file.writeAsBytesSync(response.bodyBytes);
        if (mounted) {
          setState(() {
            _imageFileList.add(XFile(file.path));
          });
        }
      }
    }
    return result;
  }

  Future deleteFavPlace({
    required String placeId,
  }) async {
    EasyLoading.show();
    var result = await favouriteRepo.deleteFavPlace(
      placeId: placeId,
    );
    EasyLoading.dismiss();
    context.router.pop();
    return result;
  }

  Future removeFavPlacePicture({
    required String placeId,
    required String fileKey,
  }) async {
    EasyLoading.show();
    var result = await favouriteRepo.removeFavPlacePicture(
      placeId: placeId,
      fileKey: fileKey,
    );
    EasyLoading.dismiss();
    context.router.pop();
    return result;
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
    favPlaceFuture = Future.wait(
        [getFavPlace(), getFavPlacePicture(placeId: widget.placeId)]);
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
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Place'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Are you sure you want to delete this place?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('CANCEL'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            deleteFavPlace(placeId: widget.placeId);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                updateFavPlace();
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future:
                favPlaceFuture, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                case ConnectionState.active:
                  return Center(child: const CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Text('error');
                    }
                    return SingleChildScrollView(
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
                                initialValue: snapshot.data[0].data[0].type,
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
                                initialValue: snapshot.data[0].data[0].name,
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
                                    snapshot.data[0].data[0].description,
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
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      setState(() {
                                        mapController = controller;
                                      });
                                      setLocationOnMap(
                                          double.parse(
                                              snapshot.data[0].data[0].lat),
                                          double.parse(
                                              snapshot.data[0].data[0].lng));
                                    },
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(_lat, _lng), zoom: 21.0),
                                    markers: Set<Marker>.of(markers.values),
                                    scrollGesturesEnabled: false,
                                    zoomGesturesEnabled: false,
                                    zoomControlsEnabled: false,
                                    onTap: (pos) async {
                                      final result = await context.router
                                          .push(FavourieMapRoute(
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
                                children: List.generate(
                                    _imageFileList.length + 1, (index) {
                                  return index == 0
                                      ? GestureDetector(
                                          onTap: () async {
                                            await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return SimpleDialog(
                                                    title: const Text(
                                                        'Add photos'),
                                                    children: <Widget>[
                                                      SimpleDialogOption(
                                                        onPressed: () async {
                                                          final XFile? photo =
                                                              await _picker.pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);
                                                          if (photo != null) {
                                                            setState(() {
                                                              _imageFileList
                                                                  .add(photo);
                                                            });
                                                          }

                                                          context.router.pop();
                                                        },
                                                        child: const Text(
                                                            'Take photo'),
                                                      ),
                                                      SimpleDialogOption(
                                                        onPressed: () async {
                                                          List<XFile>?
                                                              pickedFile =
                                                              await _picker
                                                                  .pickMultiImage();
                                                          if (pickedFile !=
                                                              null) {
                                                            setState(() {
                                                              _imageFileList
                                                                  .addAll(
                                                                      pickedFile);
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
                                                  _imageFileList[index - 1]
                                                      .path,
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
                                                    // _imageFileList
                                                    //     .removeAt(index - 1);
                                                    // removeFavPlacePicture(placeId: wid, fileKey: fileKey)
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
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
                    );
                  } else if (snapshot.hasError) {
                    return Text('error');
                  } else {
                    return Text('else');
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
