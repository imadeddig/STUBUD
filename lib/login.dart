import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/imad/exploreBuddiesPage.dart';
import 'dart:ui';

import 'package:stubudmvp/welcome.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  const Explorebuddiespage()), 
          (route) =>
              false,
        ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalPadding = screenHeight * 0.11;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>const Welcome()),
              ModalRoute.withName('/'), 
            );
           
          },
        ),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildBlurEffect(),
          _buildLoginForm(screenHeight, screenWidth, verticalPadding),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              const AssetImage("images/ae95db324a7d14c53b4d54357312d477.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.78),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  Widget _buildBlurEffect() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        color: Colors.black.withOpacity(0),
      ),
    );
  }

  Widget _buildLoginForm(
      double screenHeight, double screenWidth, double verticalPadding) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(),
                SizedBox(height: screenHeight * 0.10),
                _buildTextField("email or username", _emailController, false),
                SizedBox(height: screenHeight * 0.023),
                _buildTextField("password", _passwordController, true),
                SizedBox(height: screenHeight * 0.005),
                _forgetPassword(screenWidth),
                SizedBox(height: screenHeight * 0.063),
                _buildLoginButton(screenWidth),
                SizedBox(height: screenHeight * 0.055),
                _buildDivider(screenWidth),
                SizedBox(height: screenHeight * 0.06),
                _socialIcons(screenWidth),
                _buildTermsAndConditions(screenHeight, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }Widget _buildTitle() {
    return Text.rich(
      TextSpan(children: [
        _buildStyledText("S", 50, FontWeight.w700, const Color(0xFF7C90D6)),
        _buildStyledText("tu", 44, FontWeight.w400, Colors.white),
        _buildStyledText("B", 50, FontWeight.w700, const Color(0xFF7C90D6)),
        _buildStyledText("ud", 44, FontWeight.w400, Colors.white),
      ]),
    );
  }

  TextSpan _buildStyledText(
      String text, double fontSize, FontWeight weight, Color color) {
    return TextSpan(
      text: text,
      style: GoogleFonts.outfit(
        color: color,
        fontSize: fontSize,
        fontWeight: weight,
      ),
    );
  }

  Widget _buildTextField(
      String hint, TextEditingController controller, bool obscureText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        autocorrect: false,
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.23),
          filled: true,
          hintText: hint,
          hintStyle: GoogleFonts.outfit(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return obscureText
                ? 'Please enter your password'
                : 'Please enter your email';
          }
          return null;
        },
        cursorColor: const Color(0XFF7C90D6),
      ),
    );
  }

  Widget _forgetPassword(double screenwidth) => Container(
        margin: EdgeInsets.symmetric(horizontal: screenwidth * 0.115),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Forget password',
              style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 1),
            )
          ],
        ),
      );
  Widget _buildLoginButton(double screenWidth) {
    return Center(
      child: SizedBox(
        width: screenWidth * 0.35,
        child: MaterialButton(
          onPressed: () => _handleLogin(context),
          height: 55,
          color: const Color(0XFF7C90D6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          textColor: Colors.white,
          child: Text(
            "Log in",
            style:
                GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(double screenwidth) => Container(
        margin: EdgeInsets.symmetric(horizontal: screenwidth * 0.15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: Divider(color: Colors.white70)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'or continue with',
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Expanded(child: Divider(color: Colors.white)),
          ],
        ),
      );Widget _socialIcons(double screenWidth) => Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _socialIcon(Icons.facebook, () {}),
            SizedBox(
              width: screenWidth * 0.065,
            ),
            _socialIcon(Icons.facebook, () {}),
            SizedBox(
              width: screenWidth * 0.065,
            ),
            _socialIcon(Icons.facebook, () {}),
          ],
        ),
      );

  Widget _socialIcon(IconData icon, ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0XFF7C90D6),
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: const Color(0XFF7C90D6),
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions(double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.075,
          right: screenWidth * 0.01,
          left: screenWidth * 0.01),
      child: Center(
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
                          print("Privacy Policy clicked!");
                        }
                      },
                  )
                ])),
      ),
    );
  }
}
