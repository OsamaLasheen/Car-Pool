
import 'package:driver_car_pool/Screens/account_screen.dart';
import 'package:driver_car_pool/Screens/rides_screen.dart';
import 'package:driver_car_pool/Screens/ride_options.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const routeName = '/main';

  
  @override
  State<MainPage> createState() => _RoutesState();
}

class _RoutesState extends State<MainPage> {
  
  int selectedIndex = 0;

  Widget pageSelector() {
    final screens = [const RideOptions(), const Rides(),const Account()];
    return screens[selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    // print();
    return Scaffold(
      backgroundColor: Colors.white,
      body: pageSelector(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration( 
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 2, 79, 141),
              Color.fromARGB(255, 4, 117, 209),
              Color.fromARGB(255, 69, 167, 247),
              Color.fromARGB(255, 126, 190, 242),
            ] )
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [ 
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home', 
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Rides', 
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Account', 
            ),
          ],
          onTap: (newIndex) {
            setState(() {
              selectedIndex = newIndex;
            });
          },
        ),
      )
    

    );
  }
}