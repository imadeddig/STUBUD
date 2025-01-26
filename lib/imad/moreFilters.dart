import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InterestsPage extends StatefulWidget {
   String? selectedFilterMethod;

InterestsPage({Key? key, this.selectedFilterMethod}) : super(key: key);


  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  List<String> availableInterests = [];
  List<String> selectedInterests = [];
  late String filterMethod;
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.selectedFilterMethod);
    filterMethod = widget.selectedFilterMethod ?? 'languages';
    fetchInterestsFromFirestore();
  }

  // Fetch interests from Firestore
  Future<void> fetchInterestsFromFirestore() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('interests')
          .doc('interest')
          .get();

      if (docSnapshot.exists) {
        final interests = List<String>.from(docSnapshot[filterMethod=='interests'? 'interest1':filterMethod=='languages'? 'interest3':'']);
        setState(() {
          availableInterests = interests;
          print('***********************************************************');
          print(availableInterests);
        });
      }
    } catch (e) {
      print("Error fetching interests: $e");
    }
  }

  Widget styledChip(String label, double borderRadius) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.outfit(
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      backgroundColor: const Color(0xFF7C90D6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: const BorderSide(
          color: Color(0xFF7C90D6),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredInterests = availableInterests
        .where((interest) =>
            interest.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(
                  filterMethod=='interests' ?
                  "Select Interests" : filterMethod=='languages'?  "Select Languages": '', 
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, selectedInterests);
                    },
                    child: Text(
                      "Done",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7C90D6),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 0,
              height: 0,
              color: Color.fromARGB(53, 0, 0, 0),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               filterMethod=='interests' ?
                  "Selected Interests" : filterMethod=='languages'?  "Selected Languages": '', 
                style:
                    GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
              filterMethod=='interests' ?
                  "You can select up to 5 interests" : filterMethod=='languages'?  "You can select up to 5 languages": '', 
                style:
                    GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedInterests
                    .map(
                      (interest) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedInterests.remove(interest);
                          });
                        },
                        child: styledChip(interest, 20),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: filterMethod=='interests' ?
                  "Search for Interests" : filterMethod=='languages'?  "Search for Languages": '', 
                  hintStyle: GoogleFonts.outfit(
                      color: const Color.fromARGB(153, 0, 0, 0)),
                  filled: true,
                  fillColor: const Color.fromARGB(26, 124, 143, 214),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Color(0xff7C90D6)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Color(0xff7C90D6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(color: Color(0xff7C90D6), width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filteredInterests.map((interest) {
                  return GestureDetector(
                    onTap: () {
                      if (!selectedInterests.contains(interest) &&
                          selectedInterests.length < 5) {
                        setState(() {
                          selectedInterests.add(interest);
                        });
                      }
                    },
                    child: Chip(
                      label: Text(
                        interest,
                        style: GoogleFonts.outfit(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                      backgroundColor: selectedInterests.contains(interest)
                          ? Colors.grey.shade300
                          : Color.fromARGB(25, 124, 143, 214),
                      shape: const StadiumBorder(
                        side: BorderSide(
                            color: Color.fromARGB(71, 0, 0, 0)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
