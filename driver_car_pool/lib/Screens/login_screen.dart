import 'package:driver_car_pool/Screens/main_screen.dart';
import 'package:driver_car_pool/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:driver_car_pool/common/validator.dart';
import 'package:driver_car_pool/common/general_ui_functions.dart';
import 'package:driver_car_pool/firebase/login_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool emailExceptionFired = false;
  bool passExceptionFired = false;
  bool exceptionFired = false;

  GlobalKey<FormState> loginKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordObscured = true;

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
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: <Widget>[
                Positioned(
                    child: Container(
                  height: 250,
                  width: 250,
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                      child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover)),
                  )),
                ))
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Form(
                  key: loginKey,
                  child: Column(children: <Widget>[
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
                              color:
                                Color.fromARGB(255, 245, 245, 245)))),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              hintText: "XXpXXXX@eng.asu.edu.eg",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('Email can not be empty');
                              } else if (!Validator.validateEmail(value)) {
                                return ('invalid email');
                              } else if (emailExceptionFired) {
                                return ('Email does not exist!');
                              } else if (exceptionFired) {
                                return ('Email or Password is incorrect!');
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      child: Container(
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
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('Password can not be empty');
                                } else if (passExceptionFired) {
                                  return ('Password is incorrect!');
                                } else if (exceptionFired) {
                                  return ('Email or Password is incorrect!');
                                } else {
                                  return null;
                                }
                              },
                              obscureText: passwordObscured,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      passwordObscured = !passwordObscured;
                                    });
                                  },
                                  child: Icon(passwordObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GeneralUIFunctions.gradientElevatedButton(
                          const Center(
                            child: Text('Login', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
                          ),
                        () async{
                          passExceptionFired = false;
                          emailExceptionFired = false;
                          exceptionFired = false;
                          if (loginKey.currentState!.validate()) {
                            var exceptionData = await loginAuthenticator(
                                emailController.text,
                                passwordController.text);
                            if (exceptionData['PassExceptionFired'] ||
                                exceptionData['EmailExceptionFired'] ||
                                exceptionData['ExceptionFired']) {
                              passExceptionFired = exceptionData['PassExceptionFired'];
                              emailExceptionFired = exceptionData['EmailExceptionFired'];
                              exceptionFired = exceptionData['ExceptionFired'];
                              print(exceptionFired);
                              loginKey.currentState!.validate();
                            } else {
                              Navigator.pushNamed(context, MainPage.routeName);
                              //Navigator.pop(context);
                            }
                          }
                        } , 
                        55, 
                        200, 
                        10,
                        )
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    TextButton(
                      child: const Text(
                        "Don't have an account?, Signup!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(4, 182, 252, 1),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Signup.routeName);
                      },
                    )
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
