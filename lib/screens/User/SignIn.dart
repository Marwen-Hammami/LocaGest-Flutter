import 'package:flutter/material.dart';
import 'package:locagest/main.dart';
import 'package:locagest/screens/User/FogotPassword.dart';
import 'package:locagest/screens/User/SignUp.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: Color.fromARGB(255, 236, 238, 239), // Change the color of the card
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/logo_pdm.png',
                      width: 150,
                      height: 150,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        Text('Remember me'),
                        Spacer(),
                        TextButton(
                          onPressed: () {
  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
              );                          },
                          child: Text('Forgot password?'),
                        ),
                      ],
                    ),
                   ElevatedButton(
  onPressed: () {
 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );  },
  style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 57, 168, 58), // Change the button color to red
  ),
  child: Text('Sign In'),
),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
                            
                          },
                          child: Text('Sign Up'),
                        ),
                      ],
                    ),
                    Divider(),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement Google sign-in functionality
                      },
                      icon: Icon(Icons.g_translate),
                      label: Text('Sign In with Google'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement Facebook sign-in functionality
                      },
                      icon: Icon(Icons.facebook),
                      label: Text('Sign In with Facebook'),
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