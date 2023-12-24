import 'package:driver_car_pool/Screens/rides_screen.dart';
import 'package:driver_car_pool/common/general_ui_functions.dart';
import 'package:driver_car_pool/local_database/local_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  static const routeName = '/account';

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final FirebaseAuth logOut = FirebaseAuth.instance;

  final Query dbQuery = FirebaseDatabase.instance.ref().child('driver');
  final DatabaseRepository databaseRepository = DatabaseRepository();

  Future<Map<Object?, Object?>> getUserInfoFirebase () async {
    var firebaseDatabase = FirebaseDatabase.instanceFor(app: FirebaseDatabase.instance.app, 
      databaseURL: 'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();
    DataSnapshot dataSnapshot = await firebaseDatabase.child('users').get();
    Map<Object?, Object?> user = dataSnapshot.value as Map<Object?, Object?>;
    print(user);
    return user[logOut.currentUser!.uid] as Map<Object?, Object?>;
  }

  Future getUserInfoSqflite () async {
    List <Map> user = await databaseRepository.readDate(
      'SELECT * FROM user WHERE email="${logOut.currentUser!.email.toString()}"'
    );
    return user[0];
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GeneralUIFunctions.gradientAppBar('Profile'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundColor1.png'),
            fit: BoxFit.cover
          )
        ),
        child: FutureBuilder(
          future: getUserInfoSqflite(),
          builder: (context, snapshot) {
            if(snapshot.data != null){
              print(snapshot.data);
              return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 40,
                        child: Icon(Icons.person),
                      ),
                      Text(snapshot.data!['first name'].toString(), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                      Text(snapshot.data!['last name'].toString(), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.phone_android, size: 32,),
                        const SizedBox(width: 15,),
                        Text(snapshot.data!['phone number'].toString(),style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold) )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.email_outlined, size: 32,),
                        const SizedBox(width: 15,),
                        Text(logOut.currentUser!.email.toString(),style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const SizedBox(height: 40,),
                  const Divider(
                    thickness: 3,
                  ),
                  
                  
                  const SizedBox(height: 25,),
          
                  GestureDetector(
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Rides(),))
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.history, size: 46),
                          SizedBox(width: 15,),
                          Text('Your Rides',style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold) )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 250,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListTile(
                      onTap:() {
                        logOut.signOut();
                        while(Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                        leading: Icon(
                          Icons.power_settings_new,
                          size: 46,
                          color: Colors.red.shade700,
                        ),
                        title: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 32, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.red.shade700
                          ) 
                        )
                      
                    ),
                  ),
                ],
              ),
            );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      ),
    );
  }
}