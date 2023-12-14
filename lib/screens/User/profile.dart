import 'package:flutter/material.dart';
import 'package:locagest/models/User.dart';
import 'package:locagest/screens/User/DashboardUser.dart';
import 'package:locagest/services/User_service.dart'; // Import the DashboardScreen class

class UserProfile extends StatelessWidget {
  AuthService _userService = AuthService(); // Initialize the AuthService

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userService.getUserFromId(), // Call the getUserFromId method to fetch user data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data to be fetched, show a loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If an error occurred while fetching the data, display an error message
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null) {
          // If the data is null, display a message indicating that the user data is not available
          return Center(
            child: Text('User data not available'),
          );
        } else {
          // If the data is successfully fetched and not null, display the user profile
          final user = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text('User Profile'),
            ),
            body: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('images/client.png'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    user?.username ?? 'No username', // Display the user's name or a default value
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    user?.email ?? 'No email', // Display the user's email or a default value
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'New York, USA', // Replace with the user's location
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    ' '
                    
                    
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: Text(
                      'User Dashboard',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}