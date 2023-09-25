import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class UserModel {
  final String id;
  final DateTime? createdAt;
  final String name;
  final String? avatar;

  UserModel(
      {required this.id, this.createdAt, required this.name, this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
      avatar: json["avatar"],
    );
  }

  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    return createdAt?.toString().contains(filter) ?? false;
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}

@RoutePage()
class CreateServiceCarPage extends StatefulWidget {
  const CreateServiceCarPage({Key? key}) : super(key: key);

  @override
  State<CreateServiceCarPage> createState() => _CreateServiceCarPageState();
}

class _CreateServiceCarPageState extends State<CreateServiceCarPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Car'),
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
                  name: 'milage',
                  decoration: const InputDecoration(
                    labelText: 'Milage',
                    filled: true,
                    icon: Icon(Icons.onetwothree),
                  ),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // DropdownSearch<UserModel>.multiSelection(
                //   items: UserModel.fromJsonList([
                //     {
                //       "id": "1",
                //       "createdAt": "2019-09-20T21:08:20.349Z",
                //       "name": "Leonor Bins",
                //       "avatar":
                //           "https://s3.amazonaws.com/uifaces/faces/twitter/rweve/128.jpg"
                //     },
                //     {
                //       "id": "2",
                //       "createdAt": "2019-09-21T05:09:00.668Z",
                //       "name": "Miss Halle Hickle",
                //       "avatar":
                //           "https://s3.amazonaws.com/uifaces/faces/twitter/duck4fuck/128.jpg"
                //     }
                //   ]),
                //   clearButtonProps: ClearButtonProps(isVisible: true),
                //   popupProps: PopupPropsMultiSelection.modalBottomSheet(
                //     showSelectedItems: true,
                //     itemBuilder: _customPopupItemBuilderExample2,
                //     showSearchBox: true,
                //     searchFieldProps: TextFieldProps(
                //       // controller: _userEditTextController,
                //       decoration: InputDecoration(
                //         suffixIcon: IconButton(
                //           icon: Icon(Icons.clear),
                //           onPressed: () {
                //             // _userEditTextController.clear();
                //           },
                //         ),
                //       ),
                //     ),
                //   ),
                //   compareFn: (item, selectedItem) => item.id == selectedItem.id,
                //   dropdownDecoratorProps: DropDownDecoratorProps(
                //     dropdownSearchDecoration: InputDecoration(
                //       labelText: 'Users *',
                //       filled: true,
                //       fillColor:
                //           Theme.of(context).inputDecorationTheme.fillColor,
                //     ),
                //   ),
                //   dropdownBuilder: _customDropDownExampleMultiSelection,
                // ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.abc_outlined),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('data'),
                              // Spacer(),
                              Text('data'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FormBuilderDropdown<String>(
                  name: 'fuel',
                  decoration: const InputDecoration(
                    labelText: 'Fuel',
                    filled: true,
                    icon: Icon(Icons.local_gas_station),
                  ),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: ['RON95', 'Supplier', 'Other']
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
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: FormBuilderTextField(
                        name: 'price',
                        decoration: const InputDecoration(
                          labelText: 'Price/L',
                          filled: true,
                          icon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        name: 'total',
                        decoration: const InputDecoration(
                          labelText: 'Total Amount',
                          filled: true,
                        ),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        name: 'liter',
                        decoration: const InputDecoration(
                            labelText: 'Liter',
                            filled: true,
                            suffix: Text('L')),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                FormBuilderSwitch(
                  title: const Text('Is the fuel tank full?'),
                  name: 'full_tank',
                  initialValue: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.local_drink),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                FormBuilderTextField(
                  name: 'petrol_station',
                  decoration: const InputDecoration(
                    labelText: 'Petrol Station',
                    filled: true,
                    icon: Icon(Icons.location_on),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    UserModel? item,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
        subtitle: Text(item?.createdAt?.toString() ?? ''),
        leading: const CircleAvatar(
            // this does not work - throws 404 error
            // backgroundImage: NetworkImage(item.avatar ?? ''),
            ),
      ),
    );
  }

  Widget _customDropDownExampleMultiSelection(
      BuildContext context, List<UserModel?> selectedItems) {
    if (selectedItems.isEmpty) {
      return const ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(),
        title: Text("No item selected"),
      );
    }

    return Wrap(
      children: selectedItems.map((e) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: const CircleAvatar(
                  // this does not work - throws 404 error
                  // backgroundImage: NetworkImage(item.avatar ?? ''),
                  ),
              title: Text(e?.name ?? ''),
              subtitle: Text(
                e?.createdAt.toString() ?? '',
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
