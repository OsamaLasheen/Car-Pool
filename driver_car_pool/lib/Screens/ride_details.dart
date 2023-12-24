import 'package:driver_car_pool/common/general_ui_functions.dart';
import 'package:driver_car_pool/common/userInfoCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RideDetails extends StatefulWidget {
  const RideDetails({super.key});

  static const  routeName = '/ride details';
  
  @override
  State<RideDetails> createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {

  var firebaseDatabase = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL: 'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();

  bool bookedUsersFound = false;
  String day = "";

  Future<Map> getData(tripID) async{
    Map data = {};
    DataSnapshot tripSnapshot = await firebaseDatabase.child("Trips/${FirebaseAuth.instance.currentUser?.uid}/$tripID").get();
    Map<Object?, Object?> trip = tripSnapshot.value as Map<Object?, Object?>;
    bookedUsersFound = (trip['users'] != null);
    day = DateTime.parse(trip['day'].toString()).day == DateTime.now().day?"Today": "Tomorrow";
    data['trip'] = trip;
    data['bookedUsersFound'] = bookedUsersFound;
    List<Map<Object?, Object?>> allBookedUsers = [];
    if(bookedUsersFound){
      Map<Object?, Object?> bookedUsers = trip["users"] as Map<Object?, Object?>;
      bool anyPending = false;
      for(var bookedUserID in bookedUsers.keys){
        bookedUserID as String;
        var bookedUserInfo = bookedUsers[bookedUserID];
        bookedUserInfo as Map<Object?, Object?>;
        DataSnapshot dataSnapshot =  await firebaseDatabase.child("users/${bookedUserInfo['userID']}").get();
        Map<Object?, Object?> userInfo = dataSnapshot.value as Map<Object?, Object?>;
        userInfo['userStatus'] = bookedUserInfo['userStatus'];
        if(bookedUserInfo['userStatus'] == "Pending"){anyPending = true;}
        userInfo['userID'] = bookedUserID;
        userInfo['userTripID'] = tripID;
        if(userInfo['userStatus'] != '7amada'){ //rejected
          allBookedUsers.add(userInfo);
        }
      }
      data['allBookedUsers'] = allBookedUsers;
      data['anyPending'] = anyPending;
    }
    return data;
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    String tripID = ModalRoute.of(context)?.settings.arguments as String;

    firebaseDatabase.child('Trips/${FirebaseAuth.instance.currentUser?.uid}').onChildChanged.listen((event) {
      if(mounted){
        setState((){});
      }
    });

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/backgroundColor1.png'),
            fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: GeneralUIFunctions.gradientAppBar('Ride Details'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
              Center(
                child: FutureBuilder(
                  future: getData(tripID),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      Map<Object?, Object?> trip = snapshot.data?['trip'];
                      bool anyPending = snapshot.data?['anyPending'] ?? false;
                      bool bookedUsersFound = snapshot.data?['bookedUsersFound'] ?? false;
                      return Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 2, 79, 141),
                                  Color.fromARGB(255, 4, 117, 209),
                                  Color.fromARGB(255, 69, 167, 247),
                                ])),
                            width: screenwidth * 0.95,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                const Center(
                                  child: Text(
                                    'Ride Details',
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
                                      const Text(
                                        "Price",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
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
                                ),
                                const Divider(
                                  height: 40,
                                  thickness: 0.3,
                                  color: Colors.white,
                                ),
                                "${trip["rideStatus"]}" == "Available"?
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(
                                                Colors.black26),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.all(Radius.circular(15)),
                                            ))),
                                        onPressed: () async {
                                          if(!anyPending){
                                            await firebaseDatabase.child("Trips/${FirebaseAuth.instance.currentUser?.uid}/$tripID/rideStatus").set('Completed');
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: const Text('Accept/Reject Users First!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                                              duration: const Duration(milliseconds: 1500),
                                              width: screenwidth*0.9,
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
                                        child: const Text(
                                          'Complete',
                                          style: TextStyle(
                                              fontSize: 28, color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(
                                                Colors.red.shade700),
                                            shape: const MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.all(Radius.circular(15)),
                                            ))),
                                        onPressed: () async {
                                          if(!anyPending){
                                            await firebaseDatabase.child("Trips/${FirebaseAuth.instance.currentUser?.uid}/$tripID/rideStatus").set('Cancelled');
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: const Text('Accept/Reject Users First!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                                              duration: const Duration(milliseconds: 1500),
                                              width: screenwidth*0.9,
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
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 28, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ):const SizedBox()
                              ]),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          bookedUsersFound 
                          ? Column(
                            children: [
                              ...snapshot.data!['allBookedUsers'].map((userData){
                                return generateUserInfoCard(context, screenwidth, screenHeight, userData);
                              }).toList()
                            ],
                          )
                          : const SizedBox()
                        ],
                      );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}