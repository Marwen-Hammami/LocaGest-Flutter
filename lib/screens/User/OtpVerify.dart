import 'package:flutter/material.dart';
import 'package:locagest/screens/User/ResetPassword.dart';
import 'package:locagest/services/User_service.dart';

class OTPVerifyScreen extends StatefulWidget {
  @override
  _OTPVerifyScreenState createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
    AuthService _authService = AuthService(); // Initialize the AuthService

  Future<void> _verifyOTP() async {
    final otpCode = _otpController.text;
    final isOTPValid = await _authService.verifyOTP(otpCode);

    if (isOTPValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
      );
    } else {
      // Handle invalid OTP code
    }
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
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Enter the OTP code you received to verify your identity.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _otpController,
                      decoration: InputDecoration(
                        labelText: 'OTP Code',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _verifyOTP, // Call _verifyOTP function
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 57, 168, 58),
                      ),
                      child: Text('Verify'),
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