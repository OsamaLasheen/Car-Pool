import 'package:car_pool/Screens/payment_screen.dart';
import 'package:car_pool/common/general_ui_functions.dart';
import 'package:flutter/material.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  static const routeName = '/order tracking';

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {

   String paymentMethod = '';
  @override
  Widget build(BuildContext context) {
    
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    var trip = ModalRoute.of(context)?.settings.arguments as Map;

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
                    height: screenHeight * 0.8,
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
                                (paymentMethod == "")? 'Payment': paymentMethod,
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
                                    trip['day'],
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
                                "Order Status",
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
                            onPressed: () {
                              
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