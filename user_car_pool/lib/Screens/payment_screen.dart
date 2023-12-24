import 'package:car_pool/common/general_ui_functions.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

    static const routeName = '/payment';

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: GeneralUIFunctions.gradientAppBar('Payment Options'),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroundColor1.png'),
              fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                const Text('Payment Methods', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold) , textDirection: TextDirection.ltr,),
                const SizedBox(height: 30,),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cash');
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/images/cash.png', height: 50, width: 50,),
                      const SizedBox(width: 10,),
                      const Text('Cash', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    ],
                  )
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Visa');
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/images/visa.png', height: 50, width: 50,),
                      const SizedBox(width: 10,),
                      const Text('Visa', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    ],
                  )
                )
              ],
            ),
          ),
      ),
    );
  }
}