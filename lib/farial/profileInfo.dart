import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Profileinfo extends StatefulWidget {
  const Profileinfo({super.key});

  @override
  State<Profileinfo> createState() => _ProfileinfoState();
}

class _ProfileinfoState extends State<Profileinfo> {
  final List<String> dayTimes = ['Morning', 'Afternoon', 'Evening'];
  final List<String> interests = [
    'coding',
    'sport',
    'film Making ',
    'medecine',
    'music ',
    'book club',
    'add more'
  ];
  final List<String> values = [
    'integrity',
    'innovation',
    'honesty ',
  ];
  final List<String> languages = [
    'arabic',
    'english',
    'french ',
    'spanich',
    'turkish'
  ];
  final List<String> _labels3C = [
    'Study group sessions',
    'Networking',
    'Finding study buddies'
  ];
  final List<String> _labels3D = ['Library', 'Coffee shop', 'Online virtual'];

  final Set<String> __selectedLabels3 = {
    'Morning',
    'Group discussion',
    'Timed Quizzes',
    'Study group sessions',
    'Networking',
    'add more'
  };

  String? university = "The National Higher School of AI";
  String? field = "Computer Science";
  String? level = "2nd Year";
  String? location = "Somewhere,Souk-Ahras,Algeria";
  String? bio = "Ijbol cccccccccccccccccccccccccc";

  List<File?> images = List<File?>.filled(4, null);

  final ImagePicker imagePicker = ImagePicker();

  Future<void> uploadImage(ImageSource source, int index) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        images[index] = File(pickedImage.path);
      });
    } else {
      print('No image selected.');
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
                onTap: () => _showImageSourceDialog(context, 0),
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
                                images[0] = null; // Remove the image
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color:Color.fromARGB(255, 255, 255, 255), 
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
                        onTap: () => _showImageSourceDialog(context, i),
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
                                        images[i] = null; // Remove the image
                                      });
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
                buildInfoRow("Name", "Emily"),
                buildInfoRow("Date of Birth", "September 27th, 2004"),
                buildInfoRow("Gender", "Female"),
                const Divider(),
                buildInfoRow(
                  "University",
                  "$university",
                  hasArrow: true,
                  onTap: () {
                    showEditDialog(
                      context,
                      "$university",
                      (newText) {
                        setState(() {
                          university = newText; // Update the displayed text
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
                    showEditDialog(
                      context,
                      "$field",
                      (newText) {
                        setState(() {
                          field = newText; // Update the displayed text
                        });
                      },
                    );
                  },
                ),
                buildInfoRow(
                  "Educational level",
                  "$level",
                  hasArrow: true,
                  onTap: () {
                    showEditDialog(
                      context,
                      "$level",
                      (newText) {
                        setState(() {
                          level = newText; // Update the displayed text
                        });
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
                      (newText) {
                        setState(() {
                          location = newText; // Update the displayed text
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                buildInfoRow(
                  "Bio",
                  "$bio",
                  hasArrow: true,
                  onTap: () {
                    showEditDialog(
                      context,
                      "$bio",
                      (newText) {
                        setState(() {
                          bio = newText;
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
                children: interests.map((label) {
                  final bool isSelected3A = __selectedLabels3.contains(label);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (label == 'add more') {
                              Navigator.of(context).pushNamed(
                                  "more"); // Navigate to "more" screen
                            } else {
                              // Toggle selection for the label
                              if (isSelected3A) {
                                __selectedLabels3.remove(
                                    label); // Remove label if already selected
                              } else {
                                __selectedLabels3
                                    .add(label); // Add label if not selected
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected3A
                                ? const Color(0XFF7C90D6)
                                : Colors.white,
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
                                color:
                                    isSelected3A ? Colors.white : Colors.black,
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
                  final bool isSelected3B = __selectedLabels3.contains(label);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected3B) {
                              __selectedLabels3.remove(label);
                            } else {
                              __selectedLabels3.add(label);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected3B
                                ? const Color(0XFF7C90D6)
                                : Colors.white,
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
                                color:
                                    isSelected3B ? Colors.white : Colors.black,
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
                  "Spoken Languages?",
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
                  final bool isSelected3C = __selectedLabels3.contains(label);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected3C) {
                              __selectedLabels3.remove(label);
                            } else {
                              __selectedLabels3.add(label);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected3C
                                ? const Color(0XFF7C90D6)
                                : Colors.white,
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
                                color:
                                    isSelected3C ? Colors.white : Colors.black,
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
                children: dayTimes.map((label) {
                  final bool isSelected3D = __selectedLabels3.contains(label);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected3D) {
                              __selectedLabels3.remove(label);
                            } else {
                              __selectedLabels3.add(label);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected3D
                                ? const Color(0XFF7C90D6)
                                : Colors.white,
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
                                color:
                                    isSelected3D ? Colors.white : Colors.black,
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
                children: dayTimes.map((label) {
                  final bool isSelected3D = __selectedLabels3.contains(label);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected3D) {
                              __selectedLabels3.remove(label);
                            } else {
                              __selectedLabels3.add(label);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected3D
                                ? const Color(0XFF7C90D6)
                                : Colors.white,
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
                                color:
                                    isSelected3D ? Colors.white : Colors.black,
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
                children: dayTimes.map((label) {
                  final bool isSelected3D = __selectedLabels3.contains(label);
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected3D) {
                              __selectedLabels3.remove(label);
                            } else {
                              __selectedLabels3.add(label);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.05)),
                          height: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected3D
                                ? const Color(0XFF7C90D6)
                                : Colors.white,
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
                                color:
                                    isSelected3D ? Colors.white : Colors.black,
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
            height: (screenHeight * 0.2),
          ),
        ])));
  }

  Widget buildInfoRow(String title, String value,
      {bool hasArrow = false, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GestureDetector(
        onTap: hasArrow
            ? onTap
            : null, // Only make the row clickable if an arrow exists
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
              onSave(controller
                  .text); 
              Navigator.of(context).pop(); 
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
