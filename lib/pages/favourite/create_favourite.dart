import 'package:auto_route/auto_route.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateFavouritePage extends StatefulWidget {
  CreateFavouritePage({Key? key}) : super(key: key);

  @override
  State<CreateFavouritePage> createState() => _CreateFavouritePageState();
}

class _CreateFavouritePageState extends State<CreateFavouritePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> genderOptions = ['F & B', 'Supplier', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Favourite'),
      ),
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FormBuilderDropdown<String>(
                  name: 'type',
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
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
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                 SizedBox(
                  height: 16,
                ),
                FormBuilderTextField(
                  name: 'description',
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  readOnly: true,
                  onTap: (){
                    context.router.push(
                      FavourieMapRoute()
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
