import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String image;
  final List<Map<String, dynamic>> initialMessages;

  const ChatScreen({
    super.key,
    required this.name,
    required this.image,
    required this.initialMessages,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Map<String, dynamic>> messages;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    messages = List.from(widget.initialMessages);
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      setState(() {
        messages.add({"isSent": true, "text": controller.text});
        controller.clear();
      });
    }
  }

  bool showAttachmentOptions = false;

  void toggleAttachmentOptions() {
    setState(() {
      showAttachmentOptions = !showAttachmentOptions;
    });
  }

  void _showProfileDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 10,
                  title: Text(
                    'View profile',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                      Navigator.of(context).pushNamed("Explorebuddiespage");
                  },
                ),
              ),
              const Divider(thickness: 1, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 10,
                  title: Text(
                    'Unfriend',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Divider(thickness: 1, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 10,
                  title: Text(
                    'Report',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("report");
                  },
                ),
              ),
              const Divider(thickness: 1, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 10,
                  title: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _showProfileDialog,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.image),
              ),
              SizedBox(height: (screenHeight * 0.001)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.name,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(width: (screenWidth * 0.0005)),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isSent = message['isSent'];
                return Align(
                  alignment:
                      isSent ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (screenWidth * 0.0135),
                    ),
                    child: Row(
                      mainAxisAlignment: isSent
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isSent)
                          CircleAvatar(
                            radius: 23,
                            backgroundImage: AssetImage(widget.image),
                          ),
                        if (!isSent) SizedBox(width: (screenWidth * 0.009)),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.5),
                          padding: EdgeInsets.symmetric(
                              horizontal: (screenWidth * 0.0395),
                              vertical: (screenHeight * 0.0158)),
                          margin:  EdgeInsets.symmetric(vertical: (screenHeight * 0.00510)),
                          decoration: BoxDecoration(
                            color: !isSent
                                ? const Color(0xFF7C90D6)
                                : const Color(0xFFE6EAF0),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(28),
                              topRight: const Radius.circular(28),
                              bottomLeft: isSent
                                  ? const Radius.circular(28)
                                  : const Radius.circular(0),
                              bottomRight: isSent
                                  ? const Radius.circular(0)
                                  : const Radius.circular(28),
                            ),
                            border: Border.all(
                              color: isSent
                                  ? Colors.grey
                                  : const Color(0xFF7C90D6),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            message['text'],
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: isSent ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Padding(
            padding:
                 EdgeInsets.only(top: 0, bottom: (screenHeight * 0.01) , left: (screenWidth * 0.0168), right: (screenWidth * 0.0168)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showAttachmentOptions)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt, size: 16),
                        label: const Text(
                          'camera',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6EAF0),
                          foregroundColor: const Color(0xFF7C90D6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.photo, size: 16),
                        label: const Text(
                          'gallery',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6EAF0),
                          foregroundColor: const Color(0xFF7C90D6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                       const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.insert_drive_file, size: 16),
                        label: const Text(
                          'files',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6EAF0),
                          foregroundColor: const Color(0xFF7C90D6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE8EAF6),
                          border: Border.all(
                            color: const Color(0xFF7C90D6),
                            width: 1.25,
                          )),
                      child: IconButton(
                        icon: const Icon(Icons.attach_file,
                            color: Colors.black54),
                        onPressed: toggleAttachmentOptions,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE8EAF6),
                          border: Border.all(
                            color: const Color(0xFF7C90D6),
                            width: 1.25,
                          )),
                      child: IconButton(
                        icon: const Icon(Icons.share, color: Colors.black54),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFE6EAF0),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: const Color(0xFF7C90D6),
                              width: 1.25,
                            )),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: 'Message',
                                  hintStyle: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                      fontSize: 13),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 14,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: sendMessage,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
