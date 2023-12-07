import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart' ;


class User {
  final String name;
  final String role;

  User({required this.name, required this.role});
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<User> users = [
    User(name: 'John Doe', role: 'Software Developer'),
    User(name: 'Jane Smith', role: 'Product Manager'),
    User(name: 'Alice Johnson', role: 'Graphic Designer'),
  ];

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
            UserProfileSection(users: users),
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

class UserProfileSection extends StatelessWidget {
  final List<User> users;

  UserProfileSection({required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.blue,
      child: Column(
        children: users.map((user) => UserProfileCard(user: user)).toList(),
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  final User user;

  UserProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage('images/client.png'),
          ),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                user.role,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.white,
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
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController nameController =
                      TextEditingController(text: user.name);
                  TextEditingController roleController =
                      TextEditingController(text: user.role);

                  return AlertDialog(
                    title: Text('Edit User'),
                    content: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: roleController,
                          decoration: InputDecoration(labelText: 'Role'),
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
                          // Call edit function here
                        
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
    );
  }
}

// Rest of the code remains the same

class StatisticsSection extends StatelessWidget {
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
                icon: Icons.shopping_cart,
                label: 'Total Sales',
                value: '15,000',
              ),
              StatCard(
                icon: Icons.attach_money,
                label: 'Revenue',
                value: '\$10,000',
              ),
              StatCard(
                icon: Icons.person,
                label: 'Customers',
                value: '500',
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