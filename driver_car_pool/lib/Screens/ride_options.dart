import 'package:driver_car_pool/Screens/ride_offer_from.dart';
import 'package:driver_car_pool/Screens/ride_offer_to.dart';
import 'package:driver_car_pool/common/general_ui_functions.dart';
import 'package:flutter/material.dart';

class RideOptions extends StatefulWidget {
  const RideOptions({super.key});

  static const routeName = '/ride options';

  @override
  State<RideOptions> createState() => _RideOptionsState();
}

class _RideOptionsState extends State<RideOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralUIFunctions.gradientAppBar('Ride Options'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundColor1.png'),
            fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GeneralUIFunctions.gradientElevatedButton(
                const Center(
                  child: Text(
                    'From ASU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                ),
                () {
                  Navigator.pushNamed(context, OfferRideFromASU.routeName);
                },
                75, 
                300, 
                15
              ),
            GeneralUIFunctions.gradientElevatedButton(
              const Center(
                child: Text(
                  'To ASU',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
                ),
                () {
                  Navigator.pushNamed(context, OfferRideToASU.routeName);
                },
                75, 
                300, 
                15
              )
            ],
          ),
        ),
      ),

    );
  }
}