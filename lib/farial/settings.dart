import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stubudmvp/aiteur/screens/edit_account_info.dart';
import 'package:stubudmvp/chatbud/chatbud1.dart';
import 'package:stubudmvp/database/StudentProfile.dart';
import 'package:stubudmvp/farial/blocked.dart';
import 'package:stubudmvp/farial/db_helper.dart';
import 'package:stubudmvp/farial/profileInfo.dart';
import 'package:stubudmvp/imad/exploreBuddiesPage.dart';
import 'package:stubudmvp/farial/delete.dart';

class Settings extends StatefulWidget {
  final String userID;
  const Settings({super.key, required this.userID});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late FirebaseFirestore firestore;
  late CollectionReference issues;

  bool isStudyBuddiesSelected = true;
  int _currentIndex = 2;

  String username = '';
  String email = '';
  String fullName = '';
  File? pic;
  int complete = 0;
  String bio = "";

  late List interest;

  late List values;

  late String location;

  late List languages;

  late List goals;

  late String speciality;

  late String field;

  late String year;

  @override
  void initState() {
    super.initState();
    // _loadUserProfile();
    _fetchUserProfile();
      firestore = FirebaseFirestore.instance;
    issues = firestore.collection('issues');
  }

  Future<void> checkComplete() async {
    int value = 0;

    if (username != '') {
      value += 10;
    }
    if (pic != null) {
      value += 10;
    }
    if (interest != '') {
      value += 10;
    }
    if (values.isNotEmpty) {
      value += 10;
    }
    if (languages.isNotEmpty) {
      value += 10;
    }
    if (goals.isNotEmpty) {
      value += 10;
    }
    if (location != '') {
      value += 10;
    }
    if (year != '') {
      value += 10;
    }
    if (field != '') {
      value += 10;
    }
    if (speciality != '') {
      value += 10;
    }

    print("User profile completeness value: $value");

    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userID);
      await userRef.update({'complete': value});

      print("Firestore complete field updated");

      setState(() {
        complete = value;
      });
    } catch (error) {
      print("Error updating complete field: $error");
    }
  }

  Future<void> _loadUserProfile() async {
    final profileData = await UserProfileDatabaseHelper().getUserProfile();

    setState(() {
      username = profileData['username'] ?? '';
      fullName = profileData['fullName'] ?? '';
      email = profileData['email'] ?? '';
      pic = profileData['profilePicPath']?.isNotEmpty ?? false
          ? File(profileData['profilePicPath']!)
          : null;
      interest = profileData['interests'] != null
          ? List<String>.from(profileData['interests'] as Iterable)
          : [];
      values = profileData['values'] != null
          ? List<String>.from(profileData['values'] as Iterable)
          : [];

      languages = profileData['spokenLanguages'] != null
          ? List<String>.from(profileData['spokenLanguages'] as Iterable)
          : [];
      goals = profileData['goalsAndPurposes'] != null
          ? List<String>.from(profileData['goalsAndPurposes'] as Iterable)
          : [];
      location = profileData['location'] ?? '';
      field = profileData['field'] ?? '';
      speciality = profileData['speciality'] ?? '';
      year = profileData['level'] ?? '';
    });

    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userID)
              .get();

      if (profileSnapshot.exists) {
        final profileData = profileSnapshot.data();
        if (profileData != null) {
          setState(() {
            username = profileData['username'] ?? '';
            fullName = profileData['fullName'] ?? '';
            email = profileData['email'] ?? '';
            pic = profileData['profilePic']?.isNotEmpty ?? false
                ? File(profileData['profilePic']!)
                : null;
            interest = profileData['interests'] != null
                ? List<String>.from(profileData['interests'] as Iterable)
                : [];
            values = profileData['values'] != null
                ? List<String>.from(profileData['values'] as Iterable)
                : [];

            languages = profileData['spokenLanguages'] != null
                ? List<String>.from(profileData['spokenLanguages'] as Iterable)
                : [];
            goals = profileData['goalsAndPurposes'] != null
                ? List<String>.from(profileData['goalsAndPurposes'] as Iterable)
                : [];
            location = profileData['location'] ?? '';
            field = profileData['field'] ?? '';
            speciality = profileData['speciality'] ?? '';
            year = profileData['level'] ?? '';
          });
        }
        checkComplete();
        print(pic);
      } else {
        print("User profile does not exist in Firestore.");
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => Explorebuddiespage(userID: widget.userID)),
          (route) => false,
        );
        break;
      case 1:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => Chatbud1(userID: widget.userID)),
          (route) => false,
        );
        break;
      case 2:
        break;
    }
  }

  Future<void> saveImageToDatabase(String userID, String imagePath) async {
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(userID);
      await userRef.update({
        'profilePic': imagePath,
      });
      print("Image saved successfully for userID: $userID");
    } catch (e) {
      print("Error saving image: $e");
    }
    _fetchUserProfile();
  }

  void uploadImage(ImageSource source, String userID) async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      File newImage = File(pickedImage.path);

      await saveImageToDatabase(userID, pickedImage.path);

      setState(() {
        pic = newImage;
      });

      print("Image uploaded and UI updated.");
    } else {
      print('No image selected.');
    }
  }

  void Delete(String userID) async {
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(userID);

      await userRef.update({
        'profilePic': FieldValue.delete(),
      });

      print("Image removed successfully for userID: $userID");
    } catch (e) {
      print("Error removing image: $e");
    }
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userID);

      DocumentSnapshot userDoc = await userRef.get();

      int currentValue = userDoc['complete'] ?? 0;
      int updatedValue = currentValue - 10;

      if (updatedValue >= 0) {
        await userRef.update({'complete': updatedValue});
        print("Decremented 'complete' field by 10.");
      } else {
        print("Cannot decrement. Value would become negative.");
      }
    } catch (e) {
      print("Error decrementing 'complete': $e");
    }
    _fetchUserProfile();
  }

  void _showImageDialog(BuildContext context, userID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.55,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Center(
                  child: Text("Select a new profile picture",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                          textStyle: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        fontSize: 15,
                      ))),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    uploadImage(ImageSource.camera, userID);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C8FD6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 7,
                    ),
                  ),
                  child: Text(
                    "Take a photo",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    uploadImage(ImageSource.gallery, userID);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C8FD6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 7,
                    ),
                  ),
                  child: Text(
                    "Choose from gallery",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Delete(userID);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 7,
                    ),
                  ),
                  child: Text(
                    "Delete Profile Picture",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                _showImageDialog(context, widget.userID);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: CustomPaint(
                      painter: PartialCirclePainter(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: pic != null
                            ? Image.file(
                                pic!,
                                fit: BoxFit.cover,
                                width: 120,
                                height: 110,
                              )
                            : Image.asset(
                                "images/téléchargement.jpg",
                                fit: BoxFit.cover,
                                width: 120,
                                height: 110,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 40,
                        color: Color(0xFF7C90D6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF7C90D6),
                      ),
                      child: Center(
                        child: Text(
                          "$complete % complete",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              fullName,
              style: GoogleFonts.outfit(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              "@$username",
              style: GoogleFonts.outfit(
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ),
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 30),
            _buildSectionHeader(context, "Account Information"),
            const SizedBox(height: 15),
            _buildSettingsContainer(context, [
              _buildResponsiveProfileRow(
                  context,
                  "My Profile",
                  false,
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Profileinfo(userID: widget.userID)))),
              _buildResponsiveProfileRow(
                  context,
                  "Blocked users",
                  false,
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Blocked(userID: widget.userID)))),
              _buildResponsiveProfileRow(
                  context, "Search preferences", false, () {}),
              _buildResponsiveProfileRow(context, "Language", false, () {}),
              _buildResponsiveProfileRow(
                  context, "Personal info settings", true, () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditAccountInfoScreen(userID: 1)));
              }),
            ]),
            const SizedBox(height: 25),
            _buildSectionHeader(context, "StuBud Related"),
            const SizedBox(height: 15),
            _buildSettingsContainer(context, [
              _buildResponsiveProfileRow(context, "Help", false, () {}),
              _buildResponsiveProfileRow(
                  context, "Community guidelines", false, () {}),
              _buildResponsiveProfileRow(context, "Feedback", true, () {}),
            ]),
            const SizedBox(height: 25),
            _buildSettingsContainer(context, [
              _buildResponsiveProfileRow(
                  context, "Logout", false, () => _showFilterDialog(context)),
              _buildResponsiveProfileRow(context, "Delete my account", true,
                  () => showDeleteAccountDialog(context, widget.userID)),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF7C90D6),
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Buddies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'ChatHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveProfileRow(
      BuildContext context, String title, bool last, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: last
                ? BorderSide.none
                : const BorderSide(
                    color: Color.fromRGBO(124, 144, 214, 0.4),
                    width: 1.0,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsContainer(BuildContext context, List<Widget> children) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(124, 144, 214, 0.1),
        border: Border.all(
          color: const Color.fromRGBO(124, 144, 214, 0.4),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        Text(
          title,
          style: GoogleFonts.outfit(
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class PartialCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF7C90D6)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = 0.5 * 3.14;
    const sweepAngle = 1.5 * 3.14;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _showFilterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Center(
                child: Text("are you sure you want to log out?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontSize: 15,
                    ))),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C8FD6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                ),
                child: Text(
                  "Log out",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  "Cancel",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
