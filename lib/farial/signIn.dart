import 'package:flutter/material.dart';
import 'package:stubudmvp/farial/auth/firebase_auth.dart';
import '../farial/verify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signIn();
}

class _signIn extends State<signIn> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  late FirebaseFirestore firestore;
  late CollectionReference users;
  String fullName = "";

  String _statusMessage = "";

  final TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    users = firestore.collection('users');
  }

  String extractFullNameFromEmail(String email) {
    List<String> parts = email.split('@');

    if (parts.isNotEmpty) {
      String namePart = parts[0];
      List<String> nameParts = namePart.split('.');
      return nameParts.join(' ');
    } else {
      return '';
    }
  }

  void _sendCode() async {
    String _email = email.text.trim();
    if (_email.isNotEmpty) {
      await _auth.sendVerificationCode(_email);
      setState(() {
        _statusMessage = "Verification code sent to $_email.";
      });
    } else {
      setState(() {
        _statusMessage = "Please enter a valid email.";
      });
    }
  }

  bool isChecked = false;
  bool see = true;
  String? error = "";
  String? termsErr = "";

  bool validateEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    double font = MediaQuery.of(context).size.width * 0.065;

    return Scaffold(
        appBar: AppBar(
          leading: Container(
              margin: const EdgeInsets.only(top: 15, left: 5),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(124, 144, 214, 0.3),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "let's get you in ",
                    style: GoogleFonts.outfit(
                        textStyle: TextStyle(
                            fontSize: font, fontWeight: FontWeight.w500)),
                  ),
                  Text("S",
                      style: GoogleFonts.outfit(
                          textStyle: TextStyle(
                              fontSize: font,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF7C90D6)))),
                  Text("tu",
                      style: GoogleFonts.outfit(
                        textStyle: TextStyle(
                            fontSize: font, fontWeight: FontWeight.w500),
                      )),
                  Text("B",
                      style: GoogleFonts.outfit(
                        textStyle: TextStyle(
                            fontSize: font,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7C90D6)),
                      )),
                  Text("ud",
                      style: GoogleFonts.outfit(
                        textStyle: TextStyle(
                            fontSize: font, fontWeight: FontWeight.w500),
                      )),
                ]),
              ),
              Container(height: 10),
              Text("Your School Email",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                          fontSize: 38, fontWeight: FontWeight.w700))),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "we need to make sure that you are a real student to create your account ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(height: 30),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: GoogleFonts.outfit(
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            hintText: "name@university.dz",
                            hintStyle: GoogleFonts.outfit(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                            )),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            fillColor: const Color.fromRGBO(124, 144, 214, 0.1),
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        )),
                    Text("$error", style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isChecked = newValue!;
                            });
                          },
                          activeColor: const Color(0xFF7C90D6),
                          checkColor: Colors.white,
                        ),
                        Text("Agree with",
                            style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: font * 0.5))),
                        Text(" Terms & Conditions",
                            style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: font * 0.5,
                                    decoration: TextDecoration.underline))),
                      ],
                    ),
                    Text("$termsErr",
                        style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 30),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C90D6),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            if (isChecked) {
                              setState(() {
                                termsErr = "";
                              });
                            }

                            if (validateEmail(email.text)) {
                              setState(() {
                                error = "";
                              });
                              if (isChecked) {
                                try {
                                  QuerySnapshot querySnapshot = await users
                                      .where('email',
                                          isEqualTo: email.text.trim())
                                      .get();
                                  fullName =
                                      extractFullNameFromEmail(email.text);
                                  if (querySnapshot.docs.isEmpty) {
                                    DocumentReference docRef = await users.add({
                                      'email': email.text.trim(),
                                      'school': "unkown",
                                      'fullName': fullName,
                                      'active':true,
                                      'bio':"",
                                      'school':"",
                                      'profilePic':"",
                                      "complete":0,
                                    });

                                    String userId = docRef.id;

                                    _sendCode();

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => Verify(
                                          email: email.text.trim(),
                                          userID: userId),
                                    ));
                                  } else {
                                    setState(() {
                                      error =
                                          "This email is already registered.";
                                    });
                                  }
                                } catch (e) {
                                  print("Error: $e");
                                  setState(() {
                                    error =
                                        "Failed to sign in. Please try again.";
                                  });
                                }
                              } else {
                                setState(() {
                                  termsErr = "Agree with Terms";
                                });
                              }
                            } else {
                              setState(() {
                                error = "Enter a valid email.";
                              });
                            }
                          },
                          height: 55,
                          minWidth:
                              MediaQuery.of(context).size.width * 0.8 * 0.6,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          child: Text(
                            "Connect",
                            style: GoogleFonts.outfit(
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ));
  }

  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            see = !see;
          });
        },
        icon: see
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off));
  }
}
