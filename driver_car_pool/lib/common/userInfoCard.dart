import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Widget generateUserInfoCard(context, screenwidth, screenHeight, userDetails){
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
                    'Passenger Details',
                    style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
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
                        const Text("Name", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), ),
                        Text("${userDetails['first name']} ${userDetails['last name']}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), ),
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
                        const Text("Phone Number", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), ),
                        Text("${userDetails['phone number']}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), ),
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
                        const Text("Ride Status", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), ),
                        Text("${userDetails['userStatus']}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), ),
                    ],
                ),
                ),
                userDetails['userStatus'] == 'Pending'?
                Column(
                    children: [
                        const Divider(
                        height: 40,
                        thickness: 0.3,
                        color: Colors.white,
                        ),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                var firebaseDatabase = FirebaseDatabase.instanceFor(
                                    app: FirebaseDatabase.instance.app,
                                    databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();
                                await firebaseDatabase.child('Trips/${FirebaseAuth.instance.currentUser?.uid}/${userDetails["userTripID"]}/users/${userDetails["userID"]}/userStatus').set('Accepted');
                            },
                            child: const Text(
                                'Accept',
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white),
                            ),
                            ),
                            ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.black26),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                ))),
                            onPressed: () async{
                                var firebaseDatabase = FirebaseDatabase.instanceFor(
                                    app: FirebaseDatabase.instance.app,
                                    databaseURL:'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();
                                await firebaseDatabase.child('Trips/${FirebaseAuth.instance.currentUser?.uid}/${userDetails["userTripID"]}/users/${userDetails["userID"]}/userStatus').set('7amada');
                            },
                            child: const Text(
                                'Decline',
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white),
                            ),
                            ),
                        ],
                        ),
                    ],
                ):const SizedBox() 
            ]),
            ),
        ),
        SizedBox(height: screenHeight*0.03,)
      ],
    );
}