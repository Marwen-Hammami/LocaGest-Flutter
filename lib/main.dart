import 'package:flutter/material.dart';
import 'package:locagest/screens/User/DashboardUser.dart';
// import 'package:locagest/screens/User/FogotPassword.dart';
// import 'package:locagest/screens/User/OtpVerify.dart';
import 'package:locagest/screens/User/SignIn.dart';
// import 'package:locagest/screens/User/SignUp.dart';

import 'package:locagest/screens/chat_screen/dashboard_chat.dart';
import 'package:locagest/screens/Garage/Distribution/AddDistribution.dart';
import 'package:locagest/screens/Garage/Tools/AddTools.dart';
// import 'package:locagest/screens/User/DashboardUser.dart';
// import 'package:locagest/screens/User/FogotPassword.dart';
// import 'package:locagest/screens/User/OtpVerify.dart';
// import 'package:locagest/screens/User/SignIn.dart';
// import 'package:locagest/screens/User/SignUp.dart';
// import 'package:locagest/models/reservation.dart';
import 'package:locagest/providers/reservation_provider.dart';
import 'package:locagest/screens/reservation_screen/reservation_screen.dart';
import 'package:provider/provider.dart';
import 'package:locagest/screens/User/SignUp.dart';
import 'package:locagest/screens/User/profile.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
        // ... autres fournisseurs nécessaires
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: SignInScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    // DashboardScreen(),
    UserProfile(),

    // Content for Agence-Skander tab // call the external file for your home screen
    Container(
      color: Colors.purple.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Agence-Skander',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Flotte-Maamoun tab // call the external file for your home screen
    Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Flotte-Maamoun',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Reservation-Jouhayna tab // call the external file for your home screen

    ReservationScreen(),

    // Container(
    //   color: Colors.pink.shade300,
    //   alignment: Alignment.center,
    //   child: const Text(
    //     'Reservation-Jouhayna',
    //     style: TextStyle(fontSize: 40),
    //   ),
    // ),
    // Content for Garage-Chiheb Tab // call the external file for your home screen
    Builder(
      builder: (context) => Container(
        color: Colors.blue.shade100,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Garage',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToolsScreen()),
                );
              },
              child: Text("Tools"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddDistributionScreen()),
                );
              },
              child: Text("Distribution"),
            ),
          ],
        ),
      ),
    ),
    // Content for Chat-Marwen Tab // call the external file for your home screen
    ChatResponsiveDashboard(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LocaGest"),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              // called when one tab is selected
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              // bottom tab items
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  label: 'User',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Agence',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.car_rental_outlined),
                  label: 'Flotte',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_printshop_outlined),
                  label: 'Reservation',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.garage_outlined),
                  label: 'Garage',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined),
                  label: 'Chat',
                ),
              ],
            )
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedIndex: _selectedIndex,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  label: Text('User'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.business),
                  label: Text('Agence'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.car_rental_outlined),
                  label: Text('Flotte'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.local_printshop_outlined),
                  label: Text('Reservation'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.garage_outlined),
                  label: Text('Garage'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.message_outlined),
                  label: Text('Chat'),
                ),
              ],
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(
                color: Colors.teal,
              ),
              unselectedLabelTextStyle: const TextStyle(),
              // Called when one tab is selected
              leading: const Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
