import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/imad/exploreBuddiesPage.dart';

class beCool extends StatefulWidget {
  const beCool({super.key});

  @override
  State<beCool> createState() => _beCool();
}

class _beCool extends State<beCool> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
                maxHeight: 400,
              ),
              child: Image.asset(
                "images/becool.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to ",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "S",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7C90D6),
                    ),
                  ),
                ),
                Text(
                  "tu",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "B",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7C90D6),
                    ),
                  ),
                ),
                Text(
                  "ud",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Be Cool, Be Kind",
              style: GoogleFonts.outfit(
                textStyle: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "We're all about creating a supportive and positive community. Here, everyone is treated with kindness and respect.",
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Be Authentic:",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      children: [
                        Text(
                          "Be yourself. Your vibe attracts your tribe.",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

           
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stay Safe:",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      children: [
                        Text(
                          "Keep your info safe and secure. Your safety comes first.",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Respect Others:",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      children: [
                        Text(
                          "Treat others how you’d like to be treated. Simple as that.",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Be Proactive:",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 4,
                      children: [
                        Text(
                          "Help keep our community safe and report anything that feels off.",
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF7C90D6),
                  borderRadius:
                      BorderRadius.circular(40), 
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>
                            const Explorebuddiespage(), 
                      ),
                      (route) =>
                          false, 
                    );
                  },
                  height: 55,
                  minWidth: 190,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    "Let's Go",
                    style: GoogleFonts.outfit(
                        textStyle:
                            const TextStyle(color: Colors.white)), 
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
