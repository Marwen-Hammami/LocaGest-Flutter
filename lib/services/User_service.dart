  import 'dart:convert';
  import 'package:http/http.dart' as http;
import 'package:locagest/models/User.dart';
  import 'package:shared_preferences/shared_preferences.dart';


  class AuthService {
    static const String baseUrl = 'http://localhost:9090/User'; // Replace with your Node.js API URL

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

           final userId = userData['id'];
         SharedPreferences prefs = await SharedPreferences.getInstance();
         await prefs.setString('userId', userId);

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



Future<Map<String, dynamic>> updateUser({
  required String username,
  required String email,
  String? password,
  required String firstName,
  required String lastName,
  required String phoneNumber,
  required String creditCardNumber,
}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId'); // Assuming 'userId' is the key used to store the user ID in shared preferences

    if (userId == null) {
      throw Exception('User ID not found in shared preferences');
    }

    final url = '$baseUrl/$userId';
    final body = {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'creditCardNumber': creditCardNumber,
    };
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Failed to update user: ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to update user: $error');
  }
}
Future<Map<String, dynamic>> banUser(String userId, String banMessage) async {
  try {
    final url = '$baseUrl/banUser/$userId';
    final response = await http.post(Uri.parse(url), body: {'banMessage': banMessage});
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to ban user: ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to ban user: $error');
  }
}

  Future<Map<String, dynamic>> unbanUser(String userId) async {
    try {
      final url = '$baseUrl/unbanUser/$userId';
      final response = await http.post(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to unban user: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to unban user: $error');
    }
  }
   Future<void> logout() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/logout'));

      if (response.statusCode == 200) {
        // Logout successful
        print('Logout successful');
      } else {
        // Error occurred during logout
        print('Error during logout: ${response.statusCode}');
      }
    } catch (error) {
      // Error occurred while making the request
      print('Error during logout: $error');
    }
  }
Future<void> archiveUser(String userId) async {
  try {
    final url = Uri.parse('$baseUrl/archive/$userId');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      // User archived successfully
      print('User archived successfully');
    } else if (response.statusCode == 404) {
      // User not found
      print('User not found');
    } else {
      // Other error occurred
      print('Failed to archive user');
    }
  } catch (error) {
    print('Error: $error');
  }
}
 Future<Map<String, dynamic>> banUserWithDuration(String userId, int duration, String banMessage) async {
  try {
    final url = '$baseUrl/banUserWithDuration/$userId';
    final body = {'duration': duration.toString(), 'banMessage': banMessage};
    final response = await http.post(Uri.parse(url), body: body);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to ban user with duration: ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to ban user with duration: $error');
  }
}
Future<User> getUserFromId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId'); // Retrieve the user ID from shared preferences

    if (userId == null) {
      throw Exception('User ID not found in shared preferences');
    }

    final url = '$baseUrl/get/$userId'; // Assuming the API endpoint is /users/{id}
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // User found
      final userData = json.decode(response.body);
      return User.fromJson(userData);
    } else if (response.statusCode == 404) {
      // User not found
      throw Exception('User not found');
    } else {
      // Other error
      throw Exception('Failed to retrieve user: ${response.statusCode}');
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

  Future<void> deleteUser(String userId) async {
  final url = '$baseUrl/delete/$userId';

  try {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      final deletedUser = jsonDecode(response.body);
      print('User deleted: $deletedUser');
    } else {
      print('Failed to delete user. Error: ${response.statusCode}');
    }
  } catch (error) {
    print('Error occurred while deleting user: $error');
  }
}
  static Future<Map<String, dynamic>> calculateStatistics() async {
    final response = await http.get(Uri.parse('$baseUrl/stat'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to calculate statistics. Status code: ${response.statusCode}');
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
  Future<int> getUserCount() async {
  try {
    final List users = await getAllUsers();
    return users.length;
  } catch (error) {
    print('Failed to get user count: $error');
    throw error;
  }
}


  Future<Map<String, dynamic>> updateRoleById(
      String userId, String newRole, String newRate) async {
    try {
      final url = '$baseUrl/role/$userId';
      final body = {'newRole': newRole, 'newRate': newRate};
      final response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update role and rate: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to update role and rate: $error');
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