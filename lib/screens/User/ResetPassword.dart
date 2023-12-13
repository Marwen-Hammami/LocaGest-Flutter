import 'package:flutter/material.dart';
import 'package:locagest/screens/User/SignIn.dart';
import 'package:locagest/services/User_service.dart';
class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
    AuthService _authService = AuthService(); // Initialize the AuthService
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    final String newPassword = _newPasswordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (newPassword.isNotEmpty && confirmPassword.isNotEmpty) {
      final String response = await _authService.newPassword(newPassword, confirmPassword);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reset Password'),
            content: Text(response),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
            height: 400,
            child: Card(
              color: Color.fromARGB(255, 231, 237, 241),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   TextFormField(
  controller: _newPasswordController,
  decoration: InputDecoration(
    labelText: 'New Password',
  ),
  obscureText: true,
),
SizedBox(height: 20.0),
TextFormField(
  controller: _confirmPasswordController,
  decoration: InputDecoration(
    labelText: 'Confirm Password',
  ),
  obscureText: true,
),
SizedBox(height: 20.0),
ElevatedButton(
  onPressed: _resetPassword,
  style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 57, 168, 58),
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