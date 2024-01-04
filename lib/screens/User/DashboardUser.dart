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
  List<User> displayedUsers = []; // List for displaying users after search
  String searchQuery = ''; // Search query

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
  .map((user) => User(
        id: user['id'],
        email: user['email'],
        roles: user['roles'],
        
      ))
  .toList();
   displayedUsers = users; 

      });
    }).catchError((error) {
      print('Failed to fetch users: $error');
    });
  }
   void searchUser(String query) {
    final filteredUsers = users.where((user) {
      final userEmailLower = user.email!.toLowerCase();
      final searchLower = query.toLowerCase();

      return userEmailLower.contains(searchLower);
    }).toList();

    setState(() {
      searchQuery = query;
      displayedUsers = filteredUsers;
    });
  }
  void sortUsersByEmail() {
    setState(() {
      displayedUsers.sort((a, b) => a.email!.compareTo(b.email!));
    });
  }

 void banUser(User user) async {
  try {
    final response = await userService.banUser(user.id ?? '', '');
    print('User banned: ${user.email}');
    print('Response: $response');
    // Handle the response as needed
  } catch (error) {
    print('Failed to ban user: $error');
    // Handle the error accordingly
  }
}
void UnBanUser(User user) async {
  try {
    final response = await userService.unbanUser(user.id ?? '');
    print('User Unbanned: ${user.email}');
    print('Response: $response');
    // Handle the response as needed
  } catch (error) {
    print('Failed to Unban user: $error');
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
       // final userService = UserService();
        userService
            .updateRoleById(updatedUser.id ?? '', updatedUser.roles ?? '',
                updatedUser.rate ?? '')
            .then((result) {
          if (result['success']) {
            print(result['message']); // Role updated successfully
            // Handle success
          } else {
            print(result['message']); // Error message
            // Handle error
          }
        }).catchError((error) {
          print('Failed to update role: $error');
          // Handle error
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: sortUsersByEmail,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: searchUser,
                decoration: InputDecoration(
                  labelText: "Search Users",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            UserProfileSection(
              users: displayedUsers,
              editUser: editUser,
              banUser: banUser
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
    required this.banUser,

  });

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
                color: Color.fromARGB(255, 253, 253, 253),
              ),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserProfileCard(
                  user: user,
                  editUser: editUser,
                  banUser: banUser,
                  id: user.id ?? '', // Pass the id to UserProfileCard
                );
              },
            ),
    );
  }
}


class UserProfileCard extends StatelessWidget {
  final User user;
  final Function(User, User) editUser;
  final Function(User) banUser; // Add banUser function
  final String id; // Add id parameter

  UserProfileCard({
    required this.user,
    required this.editUser,
    required this.banUser, 
     required this.id, // Add id parameter

  });

  @override
  Widget build(BuildContext context) {
      print('User isArchived: ${user.isArchived}');

  return Card(
    margin: EdgeInsets.only(bottom: 20.0),
    color: user.isArchived ? Colors.grey : Colors.white,
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
                          AuthService().archiveUser(id);
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
      TextEditingController rateController =
          TextEditingController(text: user.rate);

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
            TextField(
              controller: rateController,
              decoration: InputDecoration(labelText: 'rate'),
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
              final updatedRates = rateController.text;

              // Create a new User object with updated values
              final newUser = User(
                id: id, // Pass the id of the user
                email: updatedUsername,
                roles: updatedRoles,
                rate: updatedRates,
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
  onPressed: () async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String banMessage = ''; // Initialize the ban message variable
        return AlertDialog(
          title: Text('Ban User'),
          content: Column(
            children: [
              Text('Are you sure you want to ban this user?'),
              TextField(
                onChanged: (value) {
                  banMessage = value; // Update the ban message as the user types
                },
                decoration: InputDecoration(
                  labelText: 'Ban Message',
                ),
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
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  print('User ID to ban: $id');
                  print('Ban Message: $banMessage'); // Print the ban message
                  await AuthService().banUser(id, banMessage); // Pass the ban message to the banUser function
                  print('User banned: ${user.email}');
                } catch (error) {
                  print('Failed to ban user: $error');
                }
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
          content: Column(
            children: [
              Text('Are you sure you want to unban this user or undo a delete ?'),
              
            ]
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Unban'),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  print('User ID to unban: $id');
                  await AuthService().unbanUser(id);
                  print('User unbanned: ${user.email}');
                } catch (error) {
                  print('Failed to unban user: $error');
                }
              },
            ),
          ],
        );
      },
    );
  },
),IconButton(
  icon: Icon(Icons.access_time),
  color: Colors.purple,
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController timeController = TextEditingController();
        TextEditingController messageController = TextEditingController(); // Add the TextEditingController for banMessage

        return AlertDialog(
          title: Text('Set Ban Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Set ban time in days:'),
              TextField(
                controller: timeController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10), // Add some spacing
              Text('Ban Message:'), // Add a label for the ban message
              TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Enter ban message',
                ),
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
                final banDuration = int.tryParse(timeController.text) ?? 0;
                final banMessage = messageController.text; // Get the ban message from the text field
                AuthService().banUserWithDuration(id, banDuration, banMessage); // Call the banUserWithDuration function with banMessage
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
                value: '',
              ),
              FutureBuilder<int>(
                future: userService.getUserCount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the user count, show a loading indicator
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // If an error occurred while fetching the user count, display an error message
                    return Text(
                        'Failed to fetch user count: ${snapshot.error}');
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

class CreativeSection extends StatefulWidget {
  @override
  _CreativeSectionState createState() => _CreativeSectionState();
}

class _CreativeSectionState extends State<CreativeSection> {
  late Future<Map<String, dynamic>> _statistics;

  @override
  void initState() {
    super.initState();
    _statistics = AuthService.calculateStatistics(); // Call the method to fetch statistics
  }

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
          FutureBuilder<Map<String, dynamic>>(
            future: _statistics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final statistics = snapshot.data;
                final dataSource = <OrdinalSales>[
                  OrdinalSales('BAD', statistics?['badCount']),
                  OrdinalSales('AVERAGE', statistics?['averageCount']),
                  OrdinalSales('GOOD', statistics?['goodCount']),
                ];
                return Column(
                  children: [
                    Container(
                      height: 200.0,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          ColumnSeries<OrdinalSales, String>(
                            dataSource: dataSource,
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error occurred while calculating statistics: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
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