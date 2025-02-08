import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:stubudmvp/information.dart';
import 'dart:convert'; // Pour utf8
// Pour le hachage

import 'package:http/http.dart' as http;

import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/constant/constant.dart';
import 'package:stubudmvp/views/screens/signup_login_screens/speciality.dart';

class complete extends StatefulWidget {
  final String userID;
  const complete({super.key, required this.userID});

  @override
  State<complete> createState() => _complete();
}

class _complete extends State<complete> {
  
  Future<void> updateProfile({
    required String userID,
    required String username,
    required String phoneNumber,
    required String password,
    required String? gender,
    required String year,
    required String month,
    required String day,
  }) async {
    final url = Uri.parse('$flaskBaseUrl/update_profile');

    // Prepare the request payload
    final Map<String, dynamic> body = {
      'userID':userID,
      'username': username,
      'phoneNumber': phoneNumber,
      'password': password,
      'gender': gender,
      'year': year.toString(),
      'month': month.toString(),
      'day': day.toString(),
    };

    try {
      // Make the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      // Handle the response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Success: ${responseData['message']}');
      } else {
        final responseData = json.decode(response.body);
        print('Error: ${responseData['error']}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  bool isChecked = false;
  bool see = true;
  bool see1 = true;
  String? _selectedGender;
  String? error = "";
  String fullName = "";
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  final TextEditingController username = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController pass = TextEditingController();

  String errorMsg = "";
  String dateErr = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validateDateInputs({
    required String day,
    required String month,
    required String year,
  }) {
    if (day.isEmpty || month.isEmpty || year.isEmpty) {
      return false;
    }

    int? dayInt = int.tryParse(day);
    int? monthInt = int.tryParse(month);
    int? yearInt = int.tryParse(year);

    if (dayInt == null || monthInt == null || yearInt == null) {
      return false;
    }

    if (monthInt < 1 || monthInt > 12) {
      return false;
    }
    if (dayInt < 1 || dayInt > 31) {
      return false;
    }
    if (yearInt < 1900 || yearInt > DateTime.now().year) {
      return false;
    }

    try {
      DateTime date = DateTime(yearInt, monthInt, dayInt);
      return date.day == dayInt &&
          date.month == monthInt &&
          date.year == yearInt;
    } catch (e) {
      return false;
    }
  }

  String? validatePhone(String? phone) {
    final RegExp phoneRegex = RegExp(r'^\d{10,15}$');
    if (phone == null) {
      return "Phone number is required.";
    } else if (!phoneRegex.hasMatch(phone)) {
      return "Enter a valid phone number (10-15 digits).";
    }
    return null;
  }

  String? validateUsername(String? username) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{4,20}$');
    if (username == null) {
      return "Username is required.";
    } else if (!usernameRegex.hasMatch(username)) {
      return "Username must be 4-20 characters and contain only letters, numbers, and underscores.";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Username is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password)) {
      return 'Username must not contain special characters';
    }
    return null;
  }

  String? validateConfirmedPassword(String? pass) {
    if (pass == null) {
      return "Please confirm your password.";
    } else if (password.text != pass) {
      return "Passwords do not match.";
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedGender = null;
    error = "";
    dateErr = "";
    fetchName();
  }

  Future<void> fetchName() async {
    DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userID)
            .get();
    final profileData = profileSnapshot.data();
    if (profileData != null) {
      setState(() {
        fullName = profileData['fullName'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome In, ",
                      style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        fullName,
                        style: GoogleFonts.outfit(
                          textStyle: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7C90D6),
                          ),
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ]),
              Container(height: 10),
              Text("Complete your profile",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                      textStyle: TextStyle(
                          fontSize: screen * 0.08,
                          fontWeight: FontWeight.w700))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "your name,birthday and school are set by default,please make sure to set up your account",
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
                    right: MediaQuery.of(context).size.width * 0.1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: username,
                            validator: validateUsername,
                            decoration: InputDecoration(
                              hintText: "fill username",
                              hintStyle: GoogleFonts.outfit(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                              )),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 20),
                              fillColor:
                                  const Color.fromRGBO(124, 144, 214, 0.1),
                              filled: true,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          )),
                      const SizedBox(height: 10),
                      Text("Phone Number",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: phone,
                            validator: validatePhone,
                            decoration: InputDecoration(
                              hintText: "+213556770990",
                              hintStyle: GoogleFonts.outfit(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                              )),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 20),
                              fillColor:
                                  const Color.fromRGBO(124, 144, 214, 0.1),
                              filled: true,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          )),
                      const SizedBox(height: 10),
                      Text("Password",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: password,
                            validator: validatePassword,
                            obscureText: see,
                            decoration: InputDecoration(
                              suffixIcon: togglePassword(),
                              hintText: "enter password",
                              hintStyle: GoogleFonts.outfit(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                              )),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 20),
                              fillColor:
                                  const Color.fromRGBO(124, 144, 214, 0.1),
                              filled: true,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          )),
                      const SizedBox(height: 10),
                      Text("Confirm Password",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: pass,
                            validator: validateConfirmedPassword,
                            obscureText: see1,
                            decoration: InputDecoration(
                              suffixIcon: togglePassword1(),
                              hintText: "confirm password",
                              hintStyle: GoogleFonts.outfit(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                              )),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 20),
                              fillColor:
                                  const Color.fromRGBO(124, 144, 214, 0.1),
                              filled: true,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          )),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: GoogleFonts.outfit(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "Male",
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                          fontSize: screen * 0.03,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  leading: Radio<String>(
                                    value: "Male",
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "Female",
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                          fontSize: screen * 0.03,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  leading: Radio<String>(
                                    value: "Female",
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            error != "" ? error! : "",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Date of Birth",
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                fontSize: screen * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildDateInputField(_dayController, "DD"),
                                  const SizedBox(width: 8),
                                  _buildDateInputField(_monthController, "MM"),
                                  const SizedBox(width: 8),
                                  _buildDateInputField(_yearController, "YYYY",
                                      isWide: true),
                                ],
                              ),
                              Text(
                                "only age will be shown",
                                style: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    fontSize: screen * 0.03,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        dateErr != "" ? dateErr : "",
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 10),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C90D6),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              String day = _dayController.text;
                              String month = _monthController.text;
                              String year = _yearController.text;

                              if (_selectedGender != null) {
                                setState(() {
                                  error = "";
                                });
                              }

                              if (validateDateInputs(
                                  day: day, month: month, year: year)) {
                                setState(() {
                                  dateErr = "";
                                });
                              }

                              if (_formKey.currentState!.validate()) {
                                if (_selectedGender != null) {
                                  if (validateDateInputs(
                                      day: day, month: month, year: year)) {
                                          
                                    await updateProfile(
                                      userID:widget.userID,
                                      username: username.text,
                                      phoneNumber: phone.text,
                                      password: password.text,
                                      gender: _selectedGender,
                                      year: year,
                                      month: month,
                                      day: day,
                                    );
                                       
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Speciality(userID: widget.userID),
                                      ),
                                    );
                                  }
                                } else {
                                  setState(() {
                                    dateErr = "Please enter a valid Date";
                                  });
                                }
                              } else if (_selectedGender == null) {
                                setState(() {
                                  error = "Please select your gender.";
                                });
                              }
                            },
                            height: 55,
                            minWidth: 190,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: Text(
                              "Next",
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

  Widget togglePassword1() {
    return IconButton(
        onPressed: () {
          setState(() {
            see1 = !see1;
          });
        },
        icon: see1
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off));
  }

  Widget _buildDateInputField(TextEditingController controller, String hintText,
      {bool isWide = false}) {
    double screen = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 45,
      width: isWide ? 60 : 40,
      child: TextField(
        onChanged: (value) {
          if (hintText != "YYYY") {
            if (value.length == 2) {
              FocusScope.of(context).nextFocus();
            }
          } else {
            if (value.length == 4) {
              FocusScope.of(context).nextFocus();
            }
          }
        },
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
          textStyle: TextStyle(
            fontSize: screen * 0.03,
            fontWeight: FontWeight.w400,
          ),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.outfit(
            textStyle: TextStyle(
              fontSize: screen * 0.03,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
