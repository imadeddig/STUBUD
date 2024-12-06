// ignore_for_file: prefer__ructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    double widthbutton = screenwidth * 0.63;
    double verticalPadding = screenHeight * 0.11;

    double paddingbottom = screenHeight * 0.1155;
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Container(
            padding: EdgeInsets.only(top: verticalPadding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                    "images/ae95db324a7d14c53b4d54357312d477.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.78),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 

                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "S",
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF7C90D6),
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                          text: 'tu',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 44,
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                        text: "B",
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF7C90D6),
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                          text: 'ud',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 44,
                            fontWeight: FontWeight.w400,
                          )),
                    ]),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenwidth * 0.18),
                      child: Text(
                        "find your study buddy and make study life more fun. ",
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        textAlign: TextAlign.center,
                      )),Container(
                    padding: EdgeInsets.only(top: screenHeight * 0.4),
                    margin: EdgeInsets.only(bottom: screenHeight * 0.025),
                    width: widthbutton,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("signin");
                      },
                      height: 55,
                      color: const Color(0XFF7C90D6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      textColor: Colors.white,
                      child: Row(
                        
                        mainAxisAlignment:
                            MainAxisAlignment.center, 
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Create Account",
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("login");
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenwidth * 0.01),
                    margin: EdgeInsets.only(
                        top: paddingbottom, bottom: screenHeight * 0.004),
                    child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            text: "by signing up , you agree to our ",
                            style: GoogleFonts.outfit(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Terms and Condtions",
                                style: GoogleFonts.outfit(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  decorationThickness: 1,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (kDebugMode) {
                                      print("Terms and Conditions clicked!");
                                    }
                                  },
                              ),
                              TextSpan(
                                text: ", learn how we use your data in our ",
                                style: GoogleFonts.outfit(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: GoogleFonts.outfit(fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  decorationThickness: 1,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (kDebugMode) {
                                      print("Privacy Policy clicked!");
                                    }
                                  },
                              )
                            ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
