
import 'package:flutter/material.dart';
import 'package:locagest/screens/Garage/Tools/ListViewTools.dart';
import 'package:locagest/screens/User/SignIn.dart';
class ModifyToolsScreen extends StatefulWidget {
  @override
  _AddToolsScreenState createState() => _AddToolsScreenState();
}

class _AddToolsScreenState extends State<ModifyToolsScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier Tools"),
      ),
      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, const Color.fromARGB(255, 223, 223, 227)],
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Marque',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Quantite',
                      ),
                      obscureText: true,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Type',
                      ),
                      obscureText: true,
                    ),
                    Image.asset(
                      'assets/images/images.jpg',
                      width: 150,
                      height: 150,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        TextButton(
                          onPressed: () {
  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListViewDemo()),
              );                          },
                          child: const Text('Modifier Tools'),
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
    );
  }
}