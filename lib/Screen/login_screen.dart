import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:animated_widgets_flutter/animated_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String id = "";
  String pass = "";
  bool flag = true;
  bool shake = false;

  final String finalId = "001";
  final String finalPass = "001";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            'assets/login_bg.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: SizedBox(
              width: 320,
              height: 400,
              child: Card(
                elevation: 70,
                color: Colors.white54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 3,
                            ),
                          ),
                          hintText: "Enter Glove ID Here",
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade700,
                          ),
                          icon: const Icon(
                            CupertinoIcons.chevron_up_circle,
                            color: Colors.green,
                          ),
                        ),
                        onChanged: (value) => id = value,
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade700,
                          ),
                          icon: const Icon(
                            CupertinoIcons.lock,
                            color: Colors.red,
                          ),
                        ),
                        onChanged: (value) => pass = value,
                      ),
                    ),
                    const SizedBox(height: 30),

                    ShakeAnimatedWidget(
                      enabled: shake,

                      duration: Duration(milliseconds: 200),
                      shakeAngle: Rotation.deg(z: 2),
                      curve: Curves.bounceOut,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.ease,
                        width: flag ? 200 : 100,

                        decoration: BoxDecoration(
                          color: flag ? Colors.blue : Colors.green,
                          borderRadius: flag
                              ? BorderRadius.circular(7)
                              : BorderRadius.circular(200),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),

                          onPressed: () async {
                            if (id == finalId && pass == finalPass) {
                              flag = false;
                              shake = false;
                              setState(() {});

                              await Future.delayed(Duration(seconds: 1));
                              Navigator.pushNamed(context, "/Home");
                            } else {
                              setState(() {
                                shake = true;
                              });
                              await Future.delayed(
                                const Duration(milliseconds: 600),
                              );
                              setState(() {
                                shake = false;
                              });
                              setState(() {
                                flag = true;
                              });
                            }
                          },
                          child: flag
                              ? Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  CupertinoIcons.check_mark,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    if (flag)
                      const Text(
                        "Invalid Credentials",
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
