import 'package:flutter/material.dart';
import 'package:locagest/models/User.dart';
import 'package:locagest/screens/User/DashboardUser.dart';
import 'package:locagest/screens/User/SignIn.dart';
import 'package:locagest/screens/User/SignUp.dart';
import 'package:locagest/screens/User/UpdateUser.dart';
import 'package:locagest/services/User_service.dart'; // Import the AuthService and UserService

class UserProfile extends StatelessWidget {
  final AuthService _userService = AuthService(); // Initialize the AuthService

  void logout(BuildContext context) async {
  try {
    await _userService.logout(); // Assuming this method clears user data/session
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/SignIn', // Navigate to the sign-in screen
      (route) => false, // Remove all routes below the sign-in screen
    );
  } catch (e) {
    // Handle logout error if needed
    print('Logout error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userService.getUserFromId(), // Call the getUserFromId method to fetch user data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null) {
          return Center(child: Text('User data not available'));
        } else {
          final user = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text('User Profile'),
              backgroundColor: Colors.blueAccent,
                      automaticallyImplyLeading: false, // Add this line to remove the back button

            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent, Colors.white],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('images/client.png'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      user?.username ?? 'No username',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      user?.email ?? 'No email',
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                    SizedBox(height: 16.0),
                    UserInfoRow(icon: Icons.phone, text: user?.phoneNumber ?? 'No phone number'),
                    SizedBox(height: 16.0),
                    UserInfoRow(icon: Icons.person_outline, text: user?.roles ?? 'No roles'),
                    SizedBox(height: 24.0),
                    ProfileButton(
                      text: 'Update Profile',
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfilePage())),
                    ),
                    ProfileButton(
                      text: 'User Dashboard',
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen())),
                    ),
                    ProfileButton(
                      text: 'Create New Profile',
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen())),
                    ),
                    ProfileButton(
                      text: 'Logout',
                      color: Colors.red,
                      onPressed: () => logout(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const UserInfoRow({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ],
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const ProfileButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget
build(BuildContext context) {
return ElevatedButton(
onPressed: onPressed,
style: ElevatedButton.styleFrom(
primary: color,
onPrimary: Colors.white,
padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(24.0),
),
),
child: Text(
text,
style: TextStyle(fontSize: 18.0),
),
);
}
}