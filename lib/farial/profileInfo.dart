import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stubudmvp/farial/Modify.dart';
import 'package:stubudmvp/interest1.dart';
import 'package:stubudmvp/interest2.dart';
import 'package:stubudmvp/interest3.dart';
import 'package:stubudmvp/interest4.dart';

class Profileinfo extends StatefulWidget {
  final String userID;
  const Profileinfo({super.key, required this.userID});

  @override
  State<Profileinfo> createState() => _ProfileinfoState();
}

class _ProfileinfoState extends State<Profileinfo> {
  final List<String> years = [
    "first year 1st (L1/1PC)",
    "second year 2nd (L2/2PC)",
    "third year 3rd (L3/1SC)",
    "fourth year 4th (M1/2SC)",
    "fivth year 5th (M2/3SC)",
    "sixth year 6th",
    "seventh year 7th",
  ];
  final List<String> specialities = [
    "Artificial Intelligence",
    "Data Science",
    "Software Engineering",
    "Networks",
    "Data Science",
    "Software Engineering",
    "Networks",
  ];
  void showSelectionDialog(BuildContext context, String title,
      List<String> options, Function(String?) onSelected) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              children: options.map((option) {
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    Navigator.pop(context);
                    onSelected(option);
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onSelected(null); // Handle cancellation
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  List<String> interest = [];
  List<String> values = [];
  List<String> languages = [];
  List<String> studyTimes = [];
  List<String> studyMethods = [];
  List<String> goals = [];
  List<String> skills = [];
  List<String> strength = [];
  List<String> communication = [];

  String? university = "";
  String? field = "";
  String? level = "";
  String? location = "";
  String? bio = "";
  String? name = "";
  String? dof = "";
  String? gender = "";

  List<File?> images = List<File?>.filled(4, null);

  final ImagePicker imagePicker = ImagePicker();

  Future<void> fetchFirebaseImages() async {
    try {
      final shotsCollection = await FirebaseFirestore.instance
          .collection('userImages')
          .doc(widget.userID)
          .collection('shots')
          .get();

      setState(() {
        int index = 0;
        for (var doc in shotsCollection.docs) {
          if (doc.data().containsKey('imagePath') &&
              doc['imagePath'] is String) {
            if (index < images.length) {
              images[index] = File(doc['imagePath']);
              index++;
            }
          }
        }
      });
      print('Fetched image URLs: ${images.map((file) => file?.path).toList()}');
    } catch (e) {
      print('Error fetching Firebase images: $e');
    }
  }

  Future<void> deleteImage(int index) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('userImages')
        .doc(widget.userID)
        .collection('shots')
        .where('imagePath', isEqualTo: images[index])
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs[0].reference.delete();
    }
  }

  Future<void> uploadImage(ImageSource source, int index) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        images[index] = File(pickedImage.path);
      });
      await saveImageToDatabase(widget.userID, pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future<void> saveImageToDatabase(String userID, String imagePath) async {
    try {
      CollectionReference shotsRef = FirebaseFirestore.instance
          .collection('userImages')
          .doc(userID)
          .collection('shots');

      QuerySnapshot snapshot = await shotsRef.get();

      if (snapshot.docs.length >= 4) {
        print("User already has 4 shots. Cannot add more.");
        return;
      }

      await shotsRef.add({
        'imagePath': imagePath,
      });

      print("Image saved successfully for userID: $userID");
    } catch (e) {
      print("Error saving image: $e");
    }
  }

  void _showImageSourceDialog(BuildContext context, int index) {
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  "Select Image Source",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    uploadImage(ImageSource.gallery, index);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C8FD6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 40,
                    ),
                  ),
                  child: Text(
                    "Gallery",
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
                    uploadImage(ImageSource.camera, index);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C8FD6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 40,
                    ),
                  ),
                  child: Text(
                    "Camera",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(color: Colors.white),
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

  void fetchInfo() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userID)
        .get();
    setState(() {
      bio = userDoc['bio'];
      university = userDoc['school'];
      field = userDoc['field'];
      level = userDoc['level'];
      location = userDoc['location'];
      name = userDoc['username'];
      dof = userDoc['dateOfBirth'];
      gender = userDoc['gender'];
    });
  }

 Future<void> _fetchUserInterests() async {
  try {
    DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userID)
            .get();
    
    final profileData = profileSnapshot.data();

    if (profileData != null) {
      setState(() {
        interest = profileData['interests'] != null
            ? List<String>.from(profileData['interests'] as Iterable)
            : ["nothing"];
        values = profileData['values'] != null
            ? List<String>.from(profileData['values'] as Iterable)
            : ["nothing"];
        languages = profileData['languagesSpoken'] != null
            ? List<String>.from(profileData['languagesSpoken'] as Iterable)
            : ["nothing"];
        goals = profileData['goalsAndPurposes'] != null
            ? List<String>.from(profileData['goalsAndPurposes'] as Iterable)
            : ["nothing"];
        studyTimes = profileData['studyTimes'] != null
            ? List<String>.from(profileData['studyTimes'] as Iterable)
            : ["nothing"];
        studyMethods = profileData['studyMethods'] != null
            ? List<String>.from(profileData['studyMethods'] as Iterable)
            : ["nothing"];
        skills = profileData['skills'] != null
            ? List<String>.from(profileData['skills'] as Iterable)
            : ["nothing"]; 
        strength = profileData['strength'] != null
            ? List<String>.from(profileData['strength'] as Iterable)
            : ["nothing"];
        communication = profileData['communicationMethods'] != null
            ? List<String>.from(profileData['CommunicationMethods'] as Iterable)
            : ["nothing"];
      });
    } else {
      print("No profile data found.");
    }
  } catch (error) {
    print("Error fetching user interests: $error");
  }
}

  @override
  void initState() {
    super.initState();
    fetchFirebaseImages();
    fetchInfo();
    _fetchUserInterests();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.012;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          toolbarHeight: 50,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7C90D6),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (images[0] == null) {
                    _showImageSourceDialog(context, 0);
                  } else {
                    return;
                  }
                },
                child: Container(
                  width: 220,
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: const Color.fromRGBO(124, 144, 214, 0.1),
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                      width: 2.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: images[0] != null
                            ? SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Image.file(
                                  images[0]!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.add, size: 40),
                      ),
                      if (images[0] != null)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                images[0] = null;
                              });
                              deleteImage(0);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 30,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Column for smaller images
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    for (int i = 1; i <= 3; i++) ...[
                      GestureDetector(
                        onTap: () {
                          if (images[i] == null) {
                            _showImageSourceDialog(context, i);
                          } else {
                            return;
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: i == 1
                                  ? const Radius.circular(10)
                                  : Radius.zero,
                              bottomRight: i == 3
                                  ? const Radius.circular(10)
                                  : Radius.zero,
                            ),
                            color: const Color.fromRGBO(124, 144, 214, 0.1),
                            border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 0.2),
                              width: 2.0,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: images[i] != null
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Image.file(
                                          images[i]!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(Icons.add, size: 24),
                              ),
                              if (images[i] != null)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        images[i] = null;
                                      });
                                      deleteImage(i);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      size: 30,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                buildInfoRow("Name", "$name"),
                buildInfoRow("Date of Birth", "$dof"),
                buildInfoRow("Gender", "$gender"),
                const Divider(),
                buildInfoRow(
                  "University",
                  "$university",
                  hasArrow: true,
                  onTap: () {
                    showEditDialog(
                      context,
                      "$university",
                      (newText) async {
                        setState(() {
                          university = newText;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.userID)
                            .update({
                          'school': university,
                        });
                      },
                    );
                  },
                ),
                buildInfoRow(
                  "Field",
                  "$field",
                  hasArrow: true,
                  onTap: () {
                    showSelectionDialog(
                      context,
                      "Select Field",
                      specialities,
                      (selectedField) async {
                        if (selectedField != null) {
                          setState(() {
                            field = selectedField;
                          });
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.userID)
                              .update({
                            'field': field,
                          });
                        }
                      },
                    );
                  },
                ),
                buildInfoRow(
                  "Educational level",
                  "$level",
                  hasArrow: true,
                  onTap: () {
                    showSelectionDialog(
                      context,
                      "Select Educational Level",
                      years,
                      (selectedLevel) async {
                        if (selectedLevel != null) {
                          setState(() {
                            level = selectedLevel;
                          });
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.userID)
                              .update({
                            'level': level,
                          });
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Personal information can't be changed for security measures. "
                  "If you have any problem, feel free to report it.",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                buildSectionTitle("Location"),
                buildInfoRow(
                  "Location",
                  "$location",
                  hasArrow: true,
                  onTap: () {
                    showEditDialog(
                      context,
                      "$location",
                      (newText) async {
                        setState(() {
                          location = newText;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.userID)
                            .update({'location': location});
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                buildInfoRow(
                  "Bio",
                  "$bio",
                  hasArrow: true,
                  onTap: () async {
                    showEditDialog(
                      context,
                      "$bio",
                      (newText) async {
                        setState(() {
                          bio = newText;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.userID)
                            .update({
                          'bio': bio,
                        });
                      },
                    );
                  },
                ),
                const Divider(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "About You",
                  style: GoogleFonts.outfit(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "interest",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: interest.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                     
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.01),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "values",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: values.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                     
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.01),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "Spoken Languages",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: languages.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.01),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "More about You",
                  style: GoogleFonts.outfit(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "preferred study times",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: studyTimes.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "purposes and goals",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: goals.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                     
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        
            Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "preferred study Methods",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: studyMethods.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),),
              Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "Communication Methods",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: communication.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),),
              Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "Academic Strength",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: strength.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),),
              Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Text(
                  "Skills",
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenHeight * 0.013),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: skills.map((label) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0XFF7C90D6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  );
                }).toList(),
              ),
            ),),
          SizedBox(
            height: (screenHeight * 0.2),
          ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF7C90D6),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>
                            Modify(userID: widget.userID),
                      ),
                      (route) => false,
                    );
                  },
                  height: 55,
                  minWidth: 190,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    "Modify ABOUT YOU",
                    style: GoogleFonts.outfit(
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
        ])));
  }

  Widget buildInfoRow(String title, String value,
      {bool hasArrow = false, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GestureDetector(
        onTap: hasArrow ? onTap : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                title,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (hasArrow)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

void showEditDialog(
    BuildContext context, String initialText, Function(String) onSave) {
  TextEditingController controller = TextEditingController(text: initialText);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Text'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Enter new text"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
