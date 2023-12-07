import 'package:flutter/material.dart';
import 'package:locagest/screens/User/SignIn.dart';



class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
            height: 400,
            child: Card(
              color: Color.fromARGB(255, 231, 237, 241),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Enter your new password and confirm it to reset your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'New Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
                      },
                      style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 57, 168, 58), // Change the button color to red
  ),
                      child: Text('Reset Password'),
                    ),
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