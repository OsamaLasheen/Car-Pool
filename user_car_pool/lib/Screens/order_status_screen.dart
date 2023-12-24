import 'package:car_pool/common/general_ui_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  static const routeName = '/order status';

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {

  String paymentMethod = '';

  var firebaseDatabase = FirebaseDatabase.instanceFor(
        app: FirebaseDatabase.instance.app,
        databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();

  Future<Map<Object?, Object?>> getOrderDetails(trip) async {
    DataSnapshot dataSnapshot = await firebaseDatabase.child('Trips/${trip["driverID"]}/${trip["tripID"]}').get();
    DataSnapshot dataSnapshot2 = await firebaseDatabase.child('drivers/${trip["driverID"]}').get();
    Map<Object?, Object?> driverInfo = dataSnapshot2.value as Map<Object?, Object?>;
    Map<Object?, Object?> tripDetails = dataSnapshot.value as Map<Object?, Object?>;
    Map<Object?, Object?> tripUsers = tripDetails['users'] as Map<Object?, Object?>;
    for(var userDetails in tripUsers.values){
      userDetails as Map<Object?, Object?>;
      if("${userDetails['userID']}" == "${FirebaseAuth.instance.currentUser?.uid}"){
        tripDetails['userStatus'] = "${userDetails['userStatus']}";
      }
    }
    tripDetails['driverName'] ="${driverInfo['first name']} ${driverInfo['last name']}";
    return tripDetails;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    var tempTrip = ModalRoute.of(context)?.settings.arguments as Map;
    String day = DateTime.parse(tempTrip['day'].toString()).day == DateTime.now().day?"Today": "Tomorrow";

    firebaseDatabase.child('Trips/${tempTrip["driverID"]}/${tempTrip["tripID"]}').onChildChanged.listen((event) {
      if(mounted){
        setState((){});
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GeneralUIFunctions.gradientAppBar('Order Status'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundColor1.png'),
            fit: BoxFit.fill)),
        child: FutureBuilder(
          future: getOrderDetails(tempTrip),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              Map<Object?, Object?> trip = snapshot.data as Map<Object?, Object?>;
              return Center(
                child: Container(
                  decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 2, 79, 141),
                    Color.fromARGB(255, 4, 117, 209),
                    Color.fromARGB(255, 69, 167, 247),
                  ])),
                  height: screenHeight *0.67,
                  width: screenwidth * 0.9,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            const Center(
                              child: Text(
                                'Meet at the pickup point',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Driver's Name . ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70),
                                ),
                                Text(
                                  "${trip['driverName']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 40,
                              thickness: 0.3,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Pickup",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                    ],
                                  ),
                                  
                                  Text(
                                    "${trip['pickup']}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 40,
                              thickness: 0.3,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Destination",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                    ],
                                  ),
                                  Text(
                                    "${trip['destination']}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 40,
                              thickness: 0.3,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        day,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${trip['time']}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 40,
                              thickness: 0.3,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Price",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${trip['price']}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 40,
                              thickness: 0.3,
                              color: Colors.white,
                            ),
                            "${trip['userStatus']}" == 'Accepted'?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Ride Status",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "${trip['rideStatus']}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                            :Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Order Status",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "${trip['userStatus']}" == '7amada' ? 'Declined': "${trip['userStatus']}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.07),
                    ],
                  ),
                ),
              );
            }
            else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
    );
  }
}
