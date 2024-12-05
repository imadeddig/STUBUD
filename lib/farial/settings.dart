import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/chatbud/chatbud1.dart';
import 'package:stubudmvp/imad/exploreBuddiesPage.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isStudyBuddiesSelected = true;
  int _currentIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
      switch (index) {
      case 0:
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  const Explorebuddiespage()), // Replace `ImadPage` with your actual widget
          (route) =>
              false, // This removes all the previous routes from the stack
        );
        break;
      case 1:
        
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  const Chatbud1()), // Replace `ImadPage` with your actual widget
          (route) =>
              false, // This removes all the previous routes from the stack
        );
        break;
      case 2:
        
        
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 130,
                  height: 130,
                  child: CustomPaint(
                    painter: PartialCirclePainter(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset("images/profile .png"),
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
                    child: const Icon(
                      Icons.edit,
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
                        "50% complete",
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
            Text(
              "imad eddine",
              style: GoogleFonts.outfit(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              "@imaded",
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
              _buildResponsiveProfileRow(context, "My Profile", false, () {}),
              _buildResponsiveProfileRow(context, "Blocked users", false, () {}),
              _buildResponsiveProfileRow(context, "Search preferences", false, () {}),
              _buildResponsiveProfileRow(context, "Language", false, () {}),
              _buildResponsiveProfileRow(context, "Personal info settings", true, () {
                Navigator.of(context).pushNamed("editinfoscreen");
              }),
            ]),
            const SizedBox(height: 25),
            _buildSectionHeader(context, "StuBud Related"),
            const SizedBox(height: 15),
            _buildSettingsContainer(context, [
              _buildResponsiveProfileRow(context, "Help", false, () {}),
              _buildResponsiveProfileRow(context, "Community guidelines", false, () {}),
              _buildResponsiveProfileRow(context, "Feedback", true, () {}),
            ]),
            const SizedBox(height: 25),
            _buildSettingsContainer(context, [
              _buildResponsiveProfileRow(context, "Logout", false, () => _showFilterDialog(context)),
              _buildResponsiveProfileRow(context, "Delete my account", true, () {}),
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

  Widget _buildResponsiveProfileRow(BuildContext context, String title, bool last, VoidCallback onTap) {
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
      ..strokeWidth = 5.0
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
          height: MediaQuery.of(context).size.height * 0.33,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text("are you sure you want to log out?",
                  style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    fontSize: 15,
                  ))),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);

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
                  "Log out",
                  style: GoogleFonts.outfit(
                    textStyle: TextStyle(
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
                    textStyle: TextStyle(color: Colors.black),
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
