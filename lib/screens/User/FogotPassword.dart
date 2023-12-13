import 'package:flutter/material.dart';
import 'package:locagest/screens/User/OtpVerify.dart';
import 'package:locagest/services/User_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
    AuthService _authService = AuthService(); // Initialize the AuthService

  

  Future<void> sendForgotPasswordRequest(String email) async {
    // Call the function from your service file
    await _authService.sendForgotPasswordRequest(email);
  }

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
            height: 300,
            child: Card(
              color: Color.fromARGB(255, 231, 237, 241),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot your password?',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 12, 0, 0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'No worries! Enter your email below and we will send you instructions on how to reset your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 17, 0, 0),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text;
                        sendForgotPasswordRequest(email); // Call the sendForgotPasswordRequest function
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OTPVerifyScreen()),
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