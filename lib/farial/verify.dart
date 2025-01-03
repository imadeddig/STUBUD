import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'success.dart';
import 'package:google_fonts/google_fonts.dart';
import '../database/db_helper.dart';

class Verify extends StatefulWidget {
  final int userID;

  const Verify({super.key, required this.userID});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  late Future<String?> emailFuture;

  @override
  void initState() {
    super.initState();
    emailFuture = _fetchEmail();
  }

  Future<String?> _fetchEmail() async {
    final database = await DBHelper.getDatabase();
    final result = await database.query(
      'StudentProfile',
      columns: ['email'],
      where: 'userID = ?',
      whereArgs: [widget.userID],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['email'] as String?;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Verify your Email",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter the code sent to ",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  FutureBuilder<String?>(
                    future: emailFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Text("Email not found.");
                      } else {
                        final email = snapshot.data!;
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(124, 144, 214, 0.1),
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  email,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Center(
                                child: Transform.rotate(
                                  angle: 1,
                                  child: const Icon(Icons.arrow_back,
                                      color: Colors.black, size: 20),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              Container(height: 45),
              Center(
                child: SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildVerificationField(),
                      _buildVerificationField(),
                      _buildVerificationField(),
                      _buildVerificationField(),
                      _buildVerificationField(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "it should be received in",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(" 29s",
                      style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              const SizedBox(height: 60),
              Text("didn't get a code?",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  )),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF7C90D6),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            success(userID: widget.userID), // Use widget.userID
                      ),
                    );
                  },
                  height: 55,
                  minWidth: 190,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    "Verify",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationField() {
    return SizedBox(
      height: 55,
      width: 45,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(124, 144, 214, 0.1),
          contentPadding: const EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: GoogleFonts.outfit(
          textStyle: const TextStyle(color: Colors.black),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
