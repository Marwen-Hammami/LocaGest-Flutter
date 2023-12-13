  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:shared_preferences/shared_preferences.dart';


  class AuthService {
    static const String baseUrl = 'http://192.168.1.150:9090/User'; // Replace with your Node.js API URL

    Future<Map<String, dynamic>> signInUser(String email, String password) async {
      final url = Uri.parse('$baseUrl/signingA');

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password}),
        );

        final responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          final userData = responseData['userData'];
          final token = responseData['token'];

          await saveSession('token', token);

          return {'userData': userData, 'token': token};
        } else {
          throw Exception(responseData['error']);
        }
      } catch (error) {
        throw Exception('Failed to sign in: $error');
      }
    }

Future<Map<String, dynamic>> signUpUser(String username, String email, String password) async {
  final url = Uri.parse('$baseUrl/signupA');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'roles': 'admin', // Set the default role as "admin"
      }),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      final token = responseData['token'];

      await saveSession('token', token);

      return responseData;
    } else {
      throw Exception(responseData['error']);
    }
  } catch (error) {
    throw Exception('Failed to sign up: $error');
  }
}
Future<void> sendForgotPasswordRequest(String email) async {
    final url = Uri.parse('$baseUrl/password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final message = responseData['message'];

        print(message);

        // Store email in shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
      } else {
        final responseData = json.decode(response.body);
        final error = responseData['error'];

        print(error);
      }
    } catch (error) {
      print('Failed to send forgot password request: $error');
    }
  }

Future<List<dynamic>> getAllUsers() async {
    final url = Uri.parse('$baseUrl/all');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception('Failed to fetch users: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }

  Future<bool> verifyOTP(String otpCode) async {
    // Retrieve email from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    final url = Uri.parse('$baseUrl/otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'otpCode': otpCode}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final isOTPValid = responseData['isOTPValid'];

        return isOTPValid;
      } else {
        final responseData = json.decode(response.body);
        final error = responseData['error'];

        print(error);
        return false;
      }
    } catch (error) {
      print('Error verifying OTP: $error');
      return false;
    }
  }
  Future<String> newPassword(String password, String confirmPassword) async {
        final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    final url = Uri.parse('$baseUrl/newpass');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password, 'confirmPassword': confirmPassword}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final message = responseData['message'];

        return message;
      } else {
        final responseData = json.decode(response.body);
        final error = responseData['error'];

        return error;
      }
    } catch (error) {
      print('Error updating password: $error');
      return 'An error occurred while updating the password.';
    }
  }


  static Future<Map<String, dynamic>> updateRoleByEmail(
      String email, String newRole) async {
    final String apiUrl = '$baseUrl/roles/$email';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      'roles': newRole,
    };

    final String jsonBody = json.encode(body);

    try {
      final response = await http.put(Uri.parse(apiUrl), headers: headers, body: jsonBody);
      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Role updated successfully'};
      } else {
        return {'success': false, 'message': responseBody['error'] ?? 'An error occurred'};
      }
    } catch (error) {
      return {'success': false, 'message': 'An error occurred: $error'};
    }
  }




    Future<void> saveSession(String key, String value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }
     Future<String?> getSession(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  }