import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/farial/beCool.dart';
import '../database/UserImages.dart';

class Shots extends StatefulWidget {
  final int userID;

  const Shots({super.key, required this.userID});

  @override
  State<Shots> createState() => _ShotsState();
}

class _ShotsState extends State<Shots> {
  List<File?> images = List<File?>.filled(4, null);
  final ImagePicker imagePicker = ImagePicker();

  Future<void> uploadImage(ImageSource source, int index) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        images[index] = File(pickedImage.path);
      });

      await saveImageToDatabase(pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future<void> saveImageToDatabase(String imagePath) async {
    try {
      int result = await UserImagesDB.insertUserImage(widget.userID, imagePath);
      if (result != -1) {
        print("Image saved to database");
      } else {
        print("Failed to save image to database");
      }
    } catch (e) {
      print("Error saving image to database: $e");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => beCool(userID:widget.userID)));
              },
              child: Text(
                "Skip",
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.015,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 1,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Color(0xFF7C90D6)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "6/6",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Share your favorite shots!",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  textStyle:
                      const TextStyle(fontSize: 38, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Text(
                "Pics aren’t a must, but they definitely help build trust!",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [                
                GestureDetector(
                  onTap: () => _showImageSourceDialog(context, 0),
                  child: Container(
                    width: 180,
                    height: 220,
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
                    child: images[0] != null
                        ? Image.file(images[0]!, fit: BoxFit.cover)
                        : const Icon(Icons.add, size: 40),
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
                          onTap: () => _showImageSourceDialog(context, i),
                          child: Container(
                            width: 60,
                            height: 66,
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
                            child: images[i] != null
                                ? Image.file(images[i]!, fit: BoxFit.cover)
                                : const Icon(Icons.add, size: 20),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    children: [
                      const TextSpan(
                        text:
                            "Please make sure to upload photos that do not avoid our ",
                      ),
                      TextSpan(
                        text: "community guidelines,",
                        style: GoogleFonts.outfit(
                          textStyle: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(124, 144, 214, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const TextSpan(
                        text:
                            " breaking any of the following rules will lead to ban your account.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(124, 144, 214, 0.3),
                    ),
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  beCool(userID: widget.userID,)));
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
