
import 'package:flutter/material.dart';
import 'package:locagest/screens/User/SignIn.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/logo_pdm.png',
                      width: 150,
                      height: 150,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                        const Text('Remember me'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // Implement terms and conditions functionality
                          },
                       
                          child: const Text('Terms and Conditions'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Implement sign-up functionality
                      },
                         style: ElevatedButton.styleFrom(
    primary: const Color.fromARGB(255, 57, 168, 58), // Change the button color to red
  ),
                      
                      child: const Text('Sign Up'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );                          },
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                    const Divider(),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement Google sign-up functionality
                      },
                      icon: const Icon(Icons.g_translate),
                      label: const Text('Sign Up with Google'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement Facebook sign-up functionality
                      },
                      icon: const Icon(Icons.facebook),
                      label: const Text('Sign Up with Facebook'),
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