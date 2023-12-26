import 'package:flutter/material.dart';
import 'package:locagest/screens/User/SignIn.dart';
import 'package:locagest/services/User_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _rememberMe = false;
  final AuthService _authService =
      AuthService(); // Create an instance of your AuthService

  void _signUp() async {
    try {
      // Get the values entered in the text fields
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      // Call the signUpUser method from the AuthService
      final Map<String, dynamic> signUpData = await _authService.signUpUser(
        username,
        email,
        password,
      );

      // Handle successful signup
      print('Signup successful');
      print(signUpData);
    } catch (error) {
      // Handle signup error
      print('Signup failed: $error');
    }
  }

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              const Color.fromARGB(255, 223, 223, 227)
            ],
          ),
        ),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: 400,
            height: 600,
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
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
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
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 57, 168, 58),
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
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                            );
                          },
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
