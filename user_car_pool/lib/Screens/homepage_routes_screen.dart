import 'package:car_pool/Screens/order_details_screen.dart';
import 'package:car_pool/common/general_ui_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

//add Search bar logic to filter through routes
//manage overflow when keyboard pops

class _HomePageState extends State<HomePage> {
  final Query dbQuery = FirebaseDatabase.instance.ref().child('Trips');
  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  var firebaseDatabase = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();

  Future<Map<Object?, Object?>> getRouteList() async {
    DataSnapshot dataSnapshot = await firebaseDatabase.child('Trips').get();
    Map<Object?, Object?> routes = dataSnapshot.value as Map<Object?, Object?>;
    return routes;
  }

  @override
  Widget build(BuildContext context) {

    firebaseDatabase.child('Trips').onChildChanged.listen((event) {
      if(mounted){
        setState((){});
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GeneralUIFunctions.gradientAppBar('Choose Route'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroundColor1.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: FutureBuilder(
                  future: getRouteList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if(snapshot.hasData) {
                      List<Map<Object?, Object?>> routes = [];
                      snapshot.data!.forEach(
                        (driverID, tripData) {
                          final trips = tripData as Map<Object?, Object?>;
                          trips.forEach((tripID, routedata) { 
                            routedata as Map<Object?, Object?>;
                            routedata["driverID"] = driverID as String;
                            routedata["tripID"] = tripID as String;
                            bool rideAvailable = "${routedata['rideStatus']}" == 'Available';
                            bool booked = false;
                            if (routedata["users"] != null) {
                              Map<Object?, Object?> users = routedata["users"] as Map<Object?, Object?>;
                              users.forEach((key, userData) {
                                userData as Map<Object?, Object?>;
                                if(userData["userID"] == userUid) {
                                  booked = true;
                                }
                              });
                            }
                            if(!booked && rideAvailable){
                              routes.add(routedata);
                            }
                          });
                        },
                      );
                      return ListView.builder(
                        itemCount: routes.length,
                        itemBuilder: (context, index) {
                          String day = DateTime.parse(routes[index]['day'].toString()).day == DateTime.now().day?"Today": "Tomorrow";
                          return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GeneralUIFunctions.gradientElevatedButton(
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: 130,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 30,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      routes[index]['pickup'].toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          const Icon(
                                            Icons.arrow_right_alt,
                                            size: 60,
                                          ),
                                          SizedBox(
                                              width: 130,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 30,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      routes[index]['destination'].toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              day,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              routes[index]['time'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Price',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              routes[index]['price'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                () {
                                  Navigator.pushNamed(
                                    context, 
                                    OrderDetails.routeName, 
                                    arguments: routes[index],
                                  );
                                },
                                185,
                                500,
                                10,
                              ));
                        },
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
