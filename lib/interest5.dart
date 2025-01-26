import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart'; // For current location
import 'package:stubudmvp/farial/shots.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stubudmvp/selectLocation.dart';

class Interest5 extends StatefulWidget {
  final String userID;

  const Interest5({Key? key, required this.userID}) : super(key: key);

  @override
  State<Interest5> createState() => _Interest5State();
}

class _Interest5State extends State<Interest5> {
  LatLng _selectedLocation = const LatLng(37.7749, -122.4194);
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.028;
    double progress = (5 / 6);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Shots(userID: widget.userID),
                  ),
                );
              },
              child: Text(
                "Skip",
                style: GoogleFonts.outfit(
                    color: Colors.black, fontWeight: FontWeight.w800),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: verticalPadding),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: (screenWidth * 0.2)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            valueColor:
                                const AlwaysStoppedAnimation(Color(0XFF7C90D6)),
                            minHeight: 9,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "5/6",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: (screenHeight * 0.035)),
                Center(
                  child: Text(
                    "Set Your Location",
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 21,
                    ),
                  ),
                ),
                SizedBox(height: (screenHeight * 0.0012)),
                Center(
                  child: Text(
                    "Find out who’s close by!",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.7,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: (screenHeight * 0.045)),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: (screenWidth * 0.1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 41,
                        child: TextField(
                          controller: locationController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0XFF7C90D6),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0XFF7C90D6),
                                width: 2,
                              ),
                            ),
                            hintText: "Your location",
                            hintStyle: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0XFF7C90D6),
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: (screenHeight * 0.03)),
                      InkWell(
                        onTap: () async {
                          Position position = await _getCurrentLocation();
                          setState(() {
                            locationController.text =
                                "${position.latitude}, ${position.longitude}";
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0XFF1D1B20),
                              size: 21,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "Use current location",
                              style: GoogleFonts.outfit(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: (screenHeight * 0.0095)),
                      InkWell(
                        onTap: () async {
                          LatLng? selectedLocation = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapPicker()),
                          );

                          if (selectedLocation != null) {
                            setState(() {
                              locationController.text =
                                  "${selectedLocation.latitude}, ${selectedLocation.longitude}";
                            });
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.map_outlined,
                              color: Color(0XFF1D1B20),
                              size: 21,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "Select location on map",
                              style: GoogleFonts.outfit(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.041,
            right: screenWidth * 0.06,
            child: InkWell(
              onTap: () async {
                String location = locationController.text;
                Map<String, dynamic> updatedProfile = {
                  'location': location,
                };

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.userID)
                    .update(updatedProfile);


                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Shots(userID: widget.userID),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0XFF7C90D6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception("Location services are disabled.");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
