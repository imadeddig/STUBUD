import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showDeleteAccountDialog(BuildContext context, String userID) {
  double screen = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: screen * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Delete Account",
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: screen * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "uh-oh, looks like you're about to leave us! :( Please select a reason for deleting your account",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: screen * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
               Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(thickness: 1.0, color: Colors.grey),
                    _buildReasonRow(context, "Found my study groups"),
                    const Divider(thickness: 1.0, color: Colors.grey),
                    _buildReasonRow(
                        context, "Couldn't meet compatible buddies"),
                    const Divider(thickness: 1.0, color: Colors.grey),
                    _buildReasonRow(context, "Not satisfied with the app"),
                    const Divider(thickness: 1.0, color: Colors.grey),
                    _buildReasonRow(context, "Others"),
                    const Divider(thickness: 1.0, color: Colors.grey),
                  ],
                ),
              const SizedBox(height:15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C8FD6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(262),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 35,
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: GoogleFonts.outfit(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: screen * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
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

Widget _buildReasonRow(BuildContext context, String reason) {
  return GestureDetector(
    onTap: () {

       if(reason=="Found my study groups"){
        Navigator.of(context).pushNamed("sure");
      }

      if(reason=="Couldn't meet compatible buddies"){
        Navigator.of(context).pop();
        showFilterBuddiesDialog(context);
      }
       if(reason=="Not satisfied with the app"){
        Navigator.of(context).pushNamed("causes");
        
      }
       if(reason=="Others"){
        Navigator.of(context).pushNamed("causes");
        
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              reason,
              style: GoogleFonts.outfit(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showFilterBuddiesDialog(BuildContext context) {
  double screen = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          width: screen * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                "Filter Buddies",
                style: GoogleFonts.outfit(
                  fontSize: screen * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle
              Text(
                "You can still filter people you want to see. Blabla blabl.",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: screen * 0.035,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // "Filter Buddies" Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("filter"); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C8FD6), // Light blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(262),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                ),
                child: Text(
                  "filter buddies",
                  style: GoogleFonts.outfit(
                    fontSize: screen * 0.045,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // "Delete Account" Button
              TextButton(
                onPressed: () {
                  // Handle delete account logic
                  Navigator.of(context).pop();
                },
                child: Text(
                  "delete account",
                  style: GoogleFonts.outfit(
                    fontSize: screen * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
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
