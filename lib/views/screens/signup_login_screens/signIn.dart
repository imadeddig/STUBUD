import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stubudmvp/constant/constant.dart';
import 'package:stubudmvp/services/auth/firebase_auth.dart';
import 'package:stubudmvp/views/screens/signup_login_screens/verify.dart';

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

  Future<void> addUser(String email) async {
    final url = Uri.parse('$flaskBaseUrl/add_user');
    try {
      // Extract school name from email
      String schoolName = extractSchoolFromEmail(email);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        String userId = data['userId'];

        // Save the school name to Firestore
        await users.doc(userId).set({
          'email': email,
          'school': schoolName, // Add the extracted school name here
        }, SetOptions(merge: true));

        print('User added successfully, userId: $userId');

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Verify(
            email: email,
            userID: userId,
          ),
        ));
      } else {
        print('Failed to add user: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _signUp() async {
    String email1 = email.text.trim();
    if (email1.isNotEmpty) {
      try {
        await addUser(email1);
      } catch (e) {
        setState(() {
          error = "Failed to sign up. Please try again.";
        });
      }
    } else {
      setState(() {
        error = "Please enter a valid email.";
      });
    }
  }

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

  String extractSchoolFromEmail(String email) {
    // Split the email by '@' and take the domain part
    String domain = email.split('@').last;

    // Remove the TLD (e.g., .dz) by splitting by '.' and taking the first part
    String schoolName = domain.split('.').first;

    return schoolName;
  }

  void _sendCode() async {
    String email1 = email.text.trim();
    if (email1.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse('$flaskBaseUrl/send_code'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email1}),
        );

        if (response.statusCode == 200) {
          setState(() {
            _statusMessage = "Verification code sent to $email1.";
          });
        } else {
          setState(() {
            _statusMessage = "Failed to send verification code.";
          });
        }
      } catch (e) {
        setState(() {
          _statusMessage = "An error occurred: $e";
        });
      }
    } else {
      setState(() {
        _statusMessage = "Please enter a valid email.";
      });
    }
  }

  Future<bool> verifyCode(String email, String enteredCode) async {
    try {
      final response = await http.post(
        Uri.parse('$flaskBaseUrl/verify_code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'code': enteredCode}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['success'];
      } else {
        return false;
      }
    } catch (e) {
      print("Error verifying code: $e");
      return false;
    }
  }

  bool isChecked = false;
  bool see = true;
  String? error = "";
  String? termsErr = "";

  Future<bool> validateEmail(String email) async {
    final url = Uri.parse(
        '$flaskBaseUrl/validate_email'); // Replace with your Flask server IP

    // Prepare the request payload
    Map<String, String> requestData = {
      'email': email,
    };

    try {
      // Send POST request to Flask server
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        print('Email is valid');
        return true;
      } else {
        print('Invalid email domain');
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
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

                            if (await validateEmail(email.text)) {
                              setState(() {
                                error = "";
                              });
                              if (isChecked) {
                                try {
                                  QuerySnapshot querySnapshot = await users
                                      .where('email',
                                          isEqualTo: email.text.trim())
                                      .get();

                                  if (querySnapshot.docs.isEmpty) {
                                    _sendCode();
                                    await addUser(email.text.trim());
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
