import 'package:car_pool/Screens/main_screen.dart';
import 'package:car_pool/common/general_ui_functions.dart';
import 'package:car_pool/firebase/signup_auth.dart';
import 'package:car_pool/local_database/local_database.dart';
import 'package:flutter/material.dart';
import 'package:car_pool/common/validator.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  static const routeName = '/signup';

  //signup isn't working for some reason

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool EmailExceptionFired = false;
  bool PassExceptionFired = false;
  bool phoneNumberExceptionFired = false;
  bool passwordObscured = true;

  DatabaseRepository databaseRepository = DatabaseRepository();

  GlobalKey<FormState> signupKey = GlobalKey();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/blueCurvedBackground2.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Positioned(
                  child: Center(
                      child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover)),
              ))),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: signupKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300]!,
                                            blurRadius: 20.0,
                                            offset: const Offset(0, 10))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      child: TextFormField(
                                        controller: firstNameController,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: InputBorder.none,
                                            hintText: "First Name",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return ('Field can not be empty');
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300]!,
                                            blurRadius: 20.0,
                                            offset: const Offset(0, 10))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      child: TextFormField(
                                        controller: lastNameController,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: InputBorder.none,
                                            hintText: "Last Name",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return ('Field can not be empty');
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
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
                                              color: Color.fromARGB(
                                                  255, 245, 245, 245)))),
                                  child: TextFormField(
                                    controller: phoneNumberController,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: "Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return ('Field not be empty');
                                      } else if (!Validator.validatePhoneNumber(
                                          value)) {
                                        return ('invalid phone number');
                                      } else if (phoneNumberExceptionFired) {
                                        return ('Email already in use!');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
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
                                              color: Color.fromARGB(
                                                  255, 245, 245, 245)))),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: "Email: abc@eng.asu.edu.eg",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return ('Field not be empty');
                                      } else if (!Validator.validateEmail(
                                          value)) {
                                        return ('invalid email');
                                      } else if (EmailExceptionFired) {
                                        return ('Email already in use!');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
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
                                              color: Color.fromARGB(
                                                  255, 245, 245, 245)))),
                                  child: TextFormField(
                                    obscureText: passwordObscured,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              passwordObscured =
                                                  !passwordObscured;
                                            });
                                          },
                                          child: Icon(passwordObscured
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        )),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return ('Field can not be empty');
                                      } else if (PassExceptionFired) {
                                        return ('Password is too weak!');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GeneralUIFunctions.gradientElevatedButton(
                          const Center(
                            child: Text('Signup', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
                          ),
                         
                        () async{
                          PassExceptionFired = false;
                            EmailExceptionFired = false;
                            await databaseRepository.insertDate('''
                            INSERT INTO user ('first name', 'last name', 'phone number', 'email') VALUES
                            ('${firstNameController.text}', '${lastNameController.text}', '${phoneNumberController.text}', 'user_${emailController.text}')
                          ''');
                            if (signupKey.currentState!.validate()) {
                              var ExceptionData = await signupAuthenticator(
                                  emailController.text,
                                  passwordController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  phoneNumberController.text
                                  );
                              if (!ExceptionData['ExceptionFired']) {
                                Navigator.pushNamed(context, MainPage.routeName);
                              } else {
                                PassExceptionFired =
                                    ExceptionData['PassExceptionFired'];
                                EmailExceptionFired =
                                    ExceptionData['EmailExceptionFired'];
                                signupKey.currentState!.validate();
                              }
                            }
                        } , 
                        55, 
                        250, 
                        10,
                        )
                    ),
                    // Center(
                    //     child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(10),
                    //   child: Stack(
                    //     children: [
                    //       Positioned.fill(
                    //           child: Container(
                    //         decoration: const BoxDecoration(
                    //             gradient: LinearGradient(colors: <Color>[
                    //           Color.fromARGB(255, 2, 79, 141),
                    //           Color.fromARGB(255, 4, 117, 209),
                    //           Color.fromARGB(255, 69, 167, 247),
                    //         ])),
                    //       )),
                    //       TextButton(
                    //         onPressed: () async {
                    //           PassExceptionFired = false;
                    //           EmailExceptionFired = false;
                    //           await databaseRepository.insertDate('''
                    //           INSERT INTO user ('first name', 'last name', 'phone number', 'email') VALUES
                    //           ('${firstNameController.text}', '${lastNameController.text}', '${phoneNumberController.text}', '${emailController.text}')
                    //         ''');
                    //           if (signupKey.currentState!.validate()) {
                    //             var ExceptionData = await signupAuthenticator(
                    //                 emailController.text,
                    //                 passwordController.text,
                    //                 firstNameController.text,
                    //                 lastNameController.text,
                    //                 phoneNumberController.text
                    //                 );
                    //             if (!ExceptionData['ExceptionFired']) {
                    //               Navigator.pushNamed(context, MainPage.routeName);
                    //             } else {
                    //               PassExceptionFired =
                    //                   ExceptionData['PassExceptionFired'];
                    //               EmailExceptionFired =
                    //                   ExceptionData['EmailExceptionFired'];
                    //               signupKey.currentState!.validate();
                    //             }
                    //           }
                    //         },
                    //         style: TextButton.styleFrom(
                    //           fixedSize: const Size.fromWidth(200),
                    //           padding: const EdgeInsets.all(10),
                    //           foregroundColor: Colors.white,
                    //           textStyle: const TextStyle(
                    //               fontSize: 30, fontWeight: FontWeight.bold),
                    //         ),
                    //         child: const Text('Signup'),
                    //       )
                    //     ],
                    //   ),
                    // )),
                  ])
            ],
          )),
    );
  }
}
