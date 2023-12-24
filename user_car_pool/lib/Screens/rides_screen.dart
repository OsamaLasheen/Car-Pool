import 'package:car_pool/Screens/order_status_screen.dart';
import 'package:car_pool/common/general_ui_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class ActivityHistory extends StatefulWidget {
  const ActivityHistory({super.key});

    static const routeName = '/rides';

    ///listView.builder containing history of previously booked rides
    ///add the rest od trip details
    

  @override
  State<ActivityHistory> createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory> {
  final Query dbQuery = FirebaseDatabase.instance.ref().child('Trips');
  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Map<Object?, Object?>>> getRouteList() async {
    List<Map<Object?, Object?>> routes = [];
    var firebaseDatabase = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();
    DataSnapshot dataSnapshot = await firebaseDatabase.child('users/$userUid/bookedTrips').get();
    if(dataSnapshot.value != null){
      try{
        Map<Object?, Object?> bookedTrips = dataSnapshot.value as Map<Object?, Object?>;
        for(var bookedTrip in bookedTrips.values) {
          bookedTrip as Map<Object?, Object?>;
          DataSnapshot dataSnapshot = await firebaseDatabase.child('Trips/${bookedTrip["driverID"].toString()}/${bookedTrip["tripID"].toString()}').get();
          Map<Object?, Object?> tripDetails = dataSnapshot.value as Map<Object?, Object?>;
          tripDetails['tripID'] = bookedTrip["tripID"];
          tripDetails['driverID'] = bookedTrip["driverID"];
          routes.add(tripDetails);
        }
      }
      catch(e){}
    }
    return routes;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GeneralUIFunctions.gradientAppBar('Your Rides'),
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
                    if(snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if(snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                        String day = DateTime.parse("${snapshot.data![index]['day']}").day == DateTime.now().day?"Today": "Tomorrow";
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
                                                      "${snapshot.data![index]['pickup']}",
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
                                                      "${snapshot.data![index]['destination']}",
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
                                              "${snapshot.data![index]['time']}",
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
                                    OrderStatus.routeName, 
                                    arguments: snapshot.data![index],
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