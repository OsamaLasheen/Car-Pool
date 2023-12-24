import 'package:driver_car_pool/Screens/ride_details.dart';
import 'package:driver_car_pool/common/general_ui_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Rides extends StatefulWidget {
  const Rides({super.key});

  static const routeName = '/history';

  ///listView.builder containing history of previously booked rides
  ///add the rest od trip details

  @override
  State<Rides> createState() => _RidesState();
}

class _RidesState extends State<Rides> {
  final Query dbQuery = FirebaseDatabase.instance.ref().child('Trips');
  final firebaseDatabase = FirebaseDatabase.instanceFor(
            app: FirebaseDatabase.instance.app,
            databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();

  Future<Map<Object?, Object?>> getRouteList() async {
    DataSnapshot dataSnapshot = await firebaseDatabase
        .child('Trips').child(driverUid.currentUser!.uid).get();
    Map<Object?, Object?> routes = dataSnapshot.value as Map<Object?, Object?>;
    return routes;
  }

  final FirebaseAuth driverUid = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GeneralUIFunctions.gradientAppBar('Your Rides'),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundColor1.png'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 10),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.29,
                    child: FutureBuilder(
                      future: getRouteList(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          List<Map<Object?, Object?>> routes = [];
                          snapshot.data!.forEach(
                            (key, routeData) {
                              routeData as Map<Object?, Object?>;
                              routeData['TripID'] = key;
                              routes.add(routeData);
                            },
                          );
                          return ListView.builder(
                            itemCount: routes.length,
                            itemBuilder: (context, index) {
                              print(routes[index]);
                              String day = DateTime.parse(routes[index]['day'].toString()).day == DateTime.now().day?"Today": "Tomorrow";
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GeneralUIFunctions.gradientElevatedButton(
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                    width: 130,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.location_pin,
                                                          size: 30,
                                                          color: Colors.white,
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
                                                    color: Colors.white),
                                                SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.location_pin,
                                                          size: 30,
                                                          color: Colors.white),
                                                      Expanded(
                                                        child: Text(
                                                          routes[index]['destination'].toString(),
                                                          style:
                                                              const TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    day,
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    routes[index]['time']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Price',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    routes[index]['price']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ), 
                                    () {
                                      Navigator.pushNamed(
                                        context, 
                                        RideDetails.routeName,
                                        arguments: routes[index]['TripID']);
                                    }, 
                                    195, 
                                    500, 
                                    15) 
                                  );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
