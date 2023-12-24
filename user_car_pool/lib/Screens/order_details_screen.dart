import 'package:car_pool/Screens/payment_screen.dart';
import 'package:car_pool/common/general_ui_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  static const routeName = '/order details';

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  String paymentMethod = '';
  bool canBook(pickupTime, pickupDate){
    String currTime = DateFormat('hh:mm a').format(DateTime.now());
    if(pickupTime == "7:30 AM"){
      if(pickupDate == "Today"){return false;}
      if(currTime.contains("AM")) {return true;}
      if(int.parse(currTime.split(':')[0]) < 10){return true;}
      return false;
    }
    if((currTime.contains('PM') && int.parse(currTime.split(':')[0]) < 1) || currTime.contains('AM') || pickupDate == "Tomorrow"){return true;}
    return false;
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    var trip = ModalRoute.of(context)?.settings.arguments as Map;
    String day = DateTime.parse(trip['day'].toString()).day == DateTime.now().day?"Today": "Tomorrow";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GeneralUIFunctions.gradientAppBar('Order Details'),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundColor1.png'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 2, 79, 141),
                          Color.fromARGB(255, 4, 117, 209),
                          Color.fromARGB(255, 69, 167, 247),
                        ])),
                    height: screenHeight * 0.85,
                    width: screenwidth * 0.95,
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Driver's Name . ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                            Text(
                              "driver's name ",
                              style: TextStyle(
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
                                trip['pickup'],
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
                                trip['destination'],
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
                                  const Icon(
                                    Icons.wallet,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                width: 10,
                                ),
                              Text(
                                (paymentMethod == "")? 'Cash': paymentMethod,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                                ],
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Colors.black26),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ))),
                                onPressed: () async {
                                  var paymentMethod1;
                                  paymentMethod1 = await Navigator.pushNamed(context, Payment.routeName);
                                  setState(() {
                                    paymentMethod = paymentMethod1.toString();
                                  });
                                },
                                child: const Text(
                                  'change',
                                  style: TextStyle(
                                  fontSize: 28, color: Colors.white),
                                ),
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
                                trip['time'],
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
                                trip['price'],
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order Status",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "Available",
                                style: TextStyle(
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
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.black26),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ))),
                            onPressed: () async{
                              if(canBook(trip['time'], day)) {
                                var firebaseDatabase = FirebaseDatabase.instanceFor(
                                app: FirebaseDatabase.instance.app,
                                databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();
                              await firebaseDatabase.child("users/${FirebaseAuth.instance.currentUser?.uid}/bookedTrips").push().set({
                                "driverID": trip["driverID"],
                                "tripID": trip["tripID"]
                              });
                              await firebaseDatabase.child("Trips/${trip["driverID"]}/${trip["tripID"]}/users").push().set({
                                "userStatus": 'Pending',
                                "userID": "${FirebaseAuth.instance.currentUser?.uid}"
                              });
                              Navigator.pop(context);
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: const Text('Too late to book!!'),
                                  duration: const Duration(milliseconds: 1500),
                                  width: 280.0,
                                  padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, 
                                  vertical: 15,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ));
                              }
                            },
                            child: const Text(
                              'Confirm',
                              style: TextStyle(
                                fontSize: 28, color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
