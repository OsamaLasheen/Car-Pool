import 'package:driver_car_pool/common/general_ui_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OfferRideToASU extends StatefulWidget {
  const OfferRideToASU({super.key});

  static const routeName = '/to asu';

  @override
  State<OfferRideToASU> createState() => _OfferRideToASUState();
}

class _OfferRideToASUState extends State<OfferRideToASU> {
  final Query dbQuery = FirebaseDatabase.instance.ref().child('routes');

  Future<Map<Object?, Object?>> getRouteList() async {
    var firebaseDatabase = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();
    DataSnapshot dataSnapshot = await firebaseDatabase.child('routes').get();
    Map<Object?, Object?> routes = dataSnapshot.value as Map<Object?, Object?>;
    return routes;
  }
  final FirebaseAuth driverUid = FirebaseAuth.instance;

  var dbRef = FirebaseDatabase.instanceFor(
          app: FirebaseDatabase.instance.app,
          databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref().child('Trips');

  String dropdownValue = 'Gate 3';
  String dropdownValue1 = 'today';
  TextEditingController pickupController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // function betraga3 widget te5tar feeha el order between el 2 options
  // button feeha options w lma te5tar option be8ayar lono w ye3mel 3aleh focus
  // add Search bar logic to filter through routes
  // manage overflow when keyboard pops
bool canSchedule(){
    String currTime = DateFormat('hh:mm a').format(DateTime.now());
    if(dropdownValue1 == 'today'){
      if(currTime.contains('PM')){return false;}
      if(int.parse(currTime.split(':')[0]) < 7){return true;}
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GeneralUIFunctions.gradientAppBar('Offer Ride To ASU'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroundColor1.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 15, ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 20.0,
                            offset: const Offset(0, 10))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 245, 245, 245)))),
                      child: TextFormField(
                        controller: pickupController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          hintText: "Pickup",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 16.0, bottom: 16),
                child: Container(
                  // height: 60,
                  // width: 380,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 2, 79, 141),
                        Color.fromARGB(255, 4, 117, 209),
                        Color.fromARGB(255, 69, 167, 247),
                        Color.fromARGB(255, 126, 190, 242),
                      ])),
                  child: SizedBox(
                    height: 60,
                    width: 380,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Destination:',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          DropdownButton(
                            borderRadius: BorderRadius.circular(15),
                            dropdownColor: Colors.blue.shade200,
                            value: dropdownValue,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(value: 'Gate 3', child: Text('Gate 3')),
                              DropdownMenuItem(value: 'Gate 4', child: Text('Gate 4')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15,),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 20.0,
                            offset: const Offset(0, 10))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 245, 245, 245)))),
                      child: TextFormField(
                        controller: priceController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          hintText: "Price",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 16.0,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 2, 79, 141),
                        Color.fromARGB(255, 4, 117, 209),
                        Color.fromARGB(255, 69, 167, 247),
                        Color.fromARGB(255, 126, 190, 242),
                      ])),
                  child: const SizedBox(
                    height: 60,
                    width: 380,
                    child: Center(
                      child: Text(
                        'Time: 7:30',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 16.0,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 2, 79, 141),
                        Color.fromARGB(255, 4, 117, 209),
                        Color.fromARGB(255, 69, 167, 247),
                        Color.fromARGB(255, 126, 190, 242),
                      ])),
                  child: SizedBox(
                    height: 60,
                    width: 380,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Day:',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          DropdownButton(
                            borderRadius: BorderRadius.circular(15),
                            dropdownColor: Colors.blue.shade200,
                            value: dropdownValue1,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (value) {
                              setState(() {
                                dropdownValue1 = value!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                  value: 'today', child: Text('Today')),
                              DropdownMenuItem(
                                  value: 'tommorow', child: Text('Tommorow')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GeneralUIFunctions.gradientElevatedButton(
                      const Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                          ),
                        ),
                      ), () async{
                      if(canSchedule()) {
                        await dbRef.child(driverUid.currentUser!.uid).push().set({
                        'pickup': pickupController.text,
                        'destination': dropdownValue, 
                        'time': '7:30 AM',
                        'day': dropdownValue1 == "today" ? DateTime.now().toString(): DateTime.now().add(const Duration(days: 1)).toString(),
                        'price': "${priceController.text} EPG",
                        'rideStatus': 'Available'
                      });
                      Navigator.pop(context);
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Too late to schedule!!', style: TextStyle(fontSize: 24),),
                          duration: const Duration(milliseconds: 1500),
                          width: 280.0,
                          padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, 
                          vertical: 8.0
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          ),
                        ));
                      }
                  }, 
                  75, 
                  300, 
                  15)),
            ],
          ),
        ),
      ),
    );
  }
}
