import 'package:flutter/material.dart';
import 'package:locagest/screens/Garage/Tools/ListViewTools.dart';
import 'package:locagest/screens/User/SignIn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

class ModifyDistributionScreen extends StatefulWidget {
  @override
  _ModifyDistributionScreenState createState() => _ModifyDistributionScreenState();
}

class _ModifyDistributionScreenState extends State<ModifyDistributionScreen> {
  bool _rememberMe = false;
  String _selectedTypeRepair = 'Maintenance'; // or any other default value
  String _selectedTypePieces ="Cardon";
  String _selectedTypeCars="Peugeot";
  String _selectedTypeTechnecien="Chiheb";
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier Distribution"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              const Color.fromARGB(255, 223, 223, 227),
            ],
          ),
        ),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: 400,
            height: 500,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        value: _selectedTypeRepair,
                        isExpanded: true, // Set isExpanded to true
                        items: ['Maintenance', 'Repair', 'Car Wash']
                            .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTypeRepair = newValue!;
                          });
                        },
                        hint: Text('Type Repair'),
                      ),
                      DropdownButton<String>(
                        value: _selectedTypePieces,
                        isExpanded: true, // Set isExpanded to true
                        items: ['Eau', 'Cardon', 'Phare']
                            .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTypePieces = newValue!;
                          });
                        },
                        hint: Text('Pieces'),
                      ),
                      DropdownButton<String>(
                        isExpanded: true, // Set isExpanded to true
                        value: _selectedTypeCars,
                        items: ['Peugeot', 'Mercedes', 'Kia']
                            .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTypeCars = newValue!;
                          });
                        },
                        hint: Text('Cars'),
                      ),

                      DropdownButton<String>(
                        isExpanded: true, // Set isExpanded to true
                        value: _selectedTypeTechnecien,
                        items: ['Chiheb', 'Saleh', 'Ayoub']
                            .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTypeTechnecien = newValue!;
                          });
                        },
                        hint: Text('Technecien'),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        obscureText: true,
                      ),
                      DateTimeField(
                        format: format,
                        decoration: InputDecoration(
                          labelText: 'startDate',
                        ),
                        onShowPicker: (context, currentValue) async {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                        },
                      ),
                      DateTimeField(
                        format: format,
                        decoration: InputDecoration(
                          labelText: 'EndDate',
                        ),
                        onShowPicker: (context, currentValue) async {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                        },
                      ),

                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Switch Status:'),
                          Switch(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ListViewDemo()),
                              );
                            },
                            child: const Text('Modifier Distribution'),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
