import 'package:flutter/material.dart';
import 'package:locagest/models/User.dart';
import 'package:locagest/screens/User/profile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:locagest/services/User_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<User> users = [];

  AuthService userService = AuthService(); // Initialize the AuthService

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() {
    userService.getAllUsers().then((fetchedUsers) {
      setState(() {
        users = fetchedUsers
            .map((user) => User(email: user['email'], roles: user['roles']))
            .toList();
      });
    }).catchError((error) {
      print('Failed to fetch users: $error');
    });
  }
  void banUser(User user) async {
  try {
    final response = await userService.banUser(user.id ?? '');
    print('User banned: ${user.username}');
    print('Response: $response');
    // Handle the response as needed
  } catch (error) {
    print('Failed to ban user: $error');
    // Handle the error accordingly
  }
}

  void addUser(User user) {
    setState(() {
      users.add(user);
    });
  }

  void deleteUser(User user) {
    setState(() {
      users.remove(user);
    });
  }

  void editUser(User oldUser, User newUser) {
    setState(() {
      final index = users.indexOf(oldUser);
      if (index != -1) {
        users[index] = newUser;
        final updatedUser = users[index];
        AuthService.updateRoleByEmail(updatedUser.email ?? '', updatedUser.roles ?? '')
          .then((result) {
            if (result['success']) {
              print(result['success']); // Role updated successfully
              // Handle success
            } else {
              print(result['error']); // Error message
              // Handle error
            }
          })
          .catchError((error) {
            print('Failed to update role: $error');
            // Handle error
          });
      }
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserProfileSection(
            users: users,
            editUser: editUser,
            banUser: banUser, // Pass the banUser function
          ),
          SizedBox(height: 20.0),
          StatisticsSection(),
          SizedBox(height: 20.0),
          CreativeSection(),
        ],
      ),
    ),
  );
}
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            child: Text('Go to User Profiles'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ),
          SizedBox(height: 20.0),
          StatisticsSection(),
          SizedBox(height: 20.0),
          CreativeSection(),
        ],
      ),
    ),
  );
}
class UserProfileSection extends StatelessWidget {
  final List<User> users;
  final Function(User, User) editUser;
  final Function(User) banUser;

  UserProfileSection({
    required this.users,
    required this.editUser,
    required this.banUser,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(20.0),
      color: Colors.blue,
      child: users.isEmpty
          ? Text(
              'No users found',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserProfileCard(user: user, editUser: editUser,banUser: banUser);
              },
            ),
    );
  }
}


class UserProfileCard extends StatelessWidget {
  final User user;
  final Function(User, User) editUser;
    final Function(User) banUser; // Add banUser function

  

 UserProfileCard({
    required this.user,
    required this.editUser,
    required this.banUser, // Add banUser parameter
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage(user.image ?? 'images/client.png'),
        ),
        title: Text(
          user.email ?? '',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          user.roles ?? '',
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete User'),
                      content: Text('Are you sure you want to delete this user?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Call delete function here
                            // deleteUser(user);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController nameController =
                        TextEditingController(text: user.email);
                    TextEditingController roleController =
                        TextEditingController(text: user.roles);

                    return AlertDialog(
                      title: Text('Edit User'),
                      content: Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(labelText: 'email'),
                          ),
                          TextField(
                            controller: roleController,
                            decoration: InputDecoration(labelText: 'roles'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Save'),
                          onPressed: () {
                            Navigator.of(context).pop();

                            // Retrieve the updated values from the text controllers
                            final updatedUsername = nameController.text;
                            final updatedRoles = roleController.text;

                            // Create a new User object with updated values
                            final newUser = User(
                              email: updatedUsername,
                              roles: updatedRoles,
                            );

                            // Call the editUser function to update the user
                            editUser(user, newUser);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
              IconButton(
              icon: Icon(Icons.block),
              color: Colors.orange,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Ban User'),
                      content: Text('Are you sure you want to ban this user?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Ban'),
                          onPressed: () {
                            Navigator.of(context).pop();
                           // userService.banUser(user); // Call the banUser function from the service
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            IconButton(
              icon: Icon(Icons.restore),
              color: Colors.green,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Unban User'),
                      content: Text('Are you sure you want to unban this user?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Unban'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          //  unbanUser(user); // Call the unbanUser function from the service
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            IconButton(
              icon: Icon(Icons.access_time),
              color: Colors.purple,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController timeController =
                        TextEditingController();

                    return AlertDialog(
                      title: Text('Set Ban Time'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Set ban time in minutes:'),
                          TextField(
                            controller: timeController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Ban'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            final banDuration =
                                int.tryParse(timeController.text) ?? 0;
                            //banUserWithDuration(user, banDuration); // Call the banUserWithDuration function from the service
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
       
// Rest of the code remains the same

class StatisticsSection extends StatelessWidget {

    AuthService userService = AuthService(); // Initialize the AuthService

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistics',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatCard(
                icon: Icons.person,
                label: 'Current Profile',
                value: '',
              ),
              StatCard(
                icon: Icons.attach_money,
                label: 'Revenue',
                value: '\$10,000',
              ),
              FutureBuilder<int>(
                future: userService.getUserCount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the user count, show a loading indicator
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // If an error occurred while fetching the user count, display an error message
                    return Text('Failed to fetch user count: ${snapshot.error}');
                  } else {
                    // If the user count is successfully retrieved, display the StatCard widget
                    return StatCard(
                      icon: Icons.person,
                      label: 'Users',
                      value: snapshot.data.toString(),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  StatCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30.0,
          ),
          SizedBox(height: 10.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
class CreativeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Creative Elements',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 200.0,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<OrdinalSales, String>(
                  dataSource: [
                    OrdinalSales('Jan', 5),
                    OrdinalSales('Feb', 25),
                    OrdinalSales('Mar', 100),
                    OrdinalSales('Apr', 75),
                  ],
                  xValueMapper: (OrdinalSales sales, _) => sales.month,
                  yValueMapper: (OrdinalSales sales, _) => sales.sales,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                'Creative Widget',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color:Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrdinalSales {
  final String month;
  final int sales;

  OrdinalSales(this.month, this.sales);
}