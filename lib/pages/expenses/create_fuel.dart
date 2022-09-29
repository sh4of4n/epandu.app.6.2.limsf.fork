import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class CreateFuelPage extends StatefulWidget {
  CreateFuelPage({Key? key}) : super(key: key);

  @override
  State<CreateFuelPage> createState() => _CreateFuelPageState();
}

class _CreateFuelPageState extends State<CreateFuelPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffd225),
        title: Text('Refuel'),
        actions: [
          IconButton(
            onPressed: () {},
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
                        initialValue: DateTime.now(),
                        inputType: InputType.date,
                        decoration: InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
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
                        initialValue: DateTime.now(),
                        inputType: InputType.time,
                        decoration: InputDecoration(
                          labelText: 'Time',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                FormBuilderTextField(
                  name: 'milage',
                  decoration: InputDecoration(
                    labelText: 'Milage',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.onetwothree),
                  ),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                FormBuilderDropdown<String>(
                  name: 'fuel',
                  decoration: InputDecoration(
                    labelText: 'Fuel',
                    border: OutlineInputBorder(),
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
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: FormBuilderTextField(
                        name: 'price',
                        decoration: InputDecoration(
                          labelText: 'Price/L',
                          border: OutlineInputBorder(),
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
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        name: 'total',
                        decoration: InputDecoration(
                          labelText: 'Total Amount',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        name: 'liter',
                        decoration: InputDecoration(
                            labelText: 'Liter',
                            border: OutlineInputBorder(),
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
                SizedBox(
                  height: 8.0,
                ),
                FormBuilderSwitch(
                  title: const Text('Is the fuel tank full?'),
                  name: 'full_tank',
                  initialValue: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.local_drink),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                FormBuilderTextField(
                  name: 'petrol_station',
                  decoration: InputDecoration(
                    labelText: 'Petrol Station',
                    border: OutlineInputBorder(),
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
}
