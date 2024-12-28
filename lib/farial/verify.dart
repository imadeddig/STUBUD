import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/farial/auth/firebase_auth.dart';
import 'success.dart';

class Verify extends StatefulWidget {
  final String email;
  final String userID;

  const Verify({super.key, required this.email,required this.userID});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

    final FirebaseAuthService _auth=FirebaseAuthService();
    
  final List<TextEditingController> _codeControllers =
      List.generate(5, (_) => TextEditingController());
  String errorMessage = "";

 void _verifyCode() async {
  final enteredCode = _codeControllers.map((controller) => controller.text).join();

  if (enteredCode.length == 5) {
    try {
      // Replace with your backend verification logic
      final isValid = await _auth.verifyCode(widget.email,enteredCode);

      if (isValid) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>  success(userID:widget.userID),
        ));
      } else {
        setState(() {
          errorMessage = "Invalid verification code. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred while verifying the code.";
      });
    }
  } else {
    setState(() {
      errorMessage = "Please enter the full 5-digit code.";
    });
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
                  const SizedBox(height: 7),
                  Container(
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
                            widget.email,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              Center(
                child: SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      5,
                      (index) => _buildVerificationField(index),
                    ),
                  ),
                ),
              ),
              if (errorMessage.isNotEmpty) ...[
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 60),
              Text(
                "Didn't get a code?",
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF7C90D6),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: MaterialButton(
                  onPressed: _verifyCode,
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

  Widget _buildVerificationField(int index) {
    return SizedBox(
      height: 55,
      width: 45,
      child: TextField(
        controller: _codeControllers[index],
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
          if (value.length == 1 && index < 4) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
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
