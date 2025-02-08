import 'dart:async';
import 'package:stubudmvp/views/screens/chatbud_and_report_screens/report.dart';

import 'app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:stubudmvp/constant/constant.dart';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  final String chatID;
  final String currentUserID;
  final String receiverUsername;
  final String receiverAvatarUrl;

  const ChatScreen({
    super.key,
    required this.chatID,
    required this.currentUserID,
    required this.receiverUsername,
    required this.receiverAvatarUrl,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _messageController = TextEditingController();
  late String receiverName;
  late String receiverAvatarUrl;
  final ScrollController _scrollController = ScrollController();
  bool showAttachmentOptions = false;
  late StreamSubscription _messagesSubscription;

  @override
  @override
  void initState() {
    super.initState();
    receiverName = widget.receiverUsername;
    receiverAvatarUrl = widget.receiverAvatarUrl;
  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    _subscribeToMessages();
    _markMessagesAsSeen();
  }

  @override
  void dispose() {
    _messagesSubscription.cancel();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> navigateToReport(
      BuildContext context, String chatID, String currentUserID) async {
    try {
      String receiverID = await getReceiverID(chatID, currentUserID);
      print(receiverID);
      Navigator.of(context).push(
       MaterialPageRoute(builder: (context)=>ReportScreen(userId: currentUserID, raportedId: receiverID),),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching receiver ID: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to retrieve receiver ID")),
      );
    }
  }

  Future<String> getReceiverID(String chatID, String currentUserID) async {
  final doc = await FirebaseFirestore.instance
      .collection("ChatSessions")
      .doc(chatID)
      .get();

  if (!doc.exists) throw Exception("Chat session not found");

  Map<String, dynamic> data = doc.data()!;
  print("Fetched data: $data"); // Log the entire document data

  String userID1 = data["user1ID"];
  String userID2 = data["user2ID"];
  print("userID1: $userID1, userID2: $userID2");

  return (userID1 == currentUserID) ? userID2 : userID1;
}

  void unfriendUser(
      BuildContext context, String chatID, String currentUserID) async {
    const String apiUrl = "$flaskBaseUrl/unfriend"; // Your API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "chatID": chatID,
          "currentUserID": currentUserID,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unfriended successfully!")));

        AppState.refreshChatList.value = true;
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error: ${jsonDecode(response.body)['error']}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to unfriend: $e")));
    }
  }

  Future<void> _pickImageAndUpload(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      if (kDebugMode) {
        print("Image picked: ${pickedImage.path}");
      }
      File imageFile = File(pickedImage.path);

      try {
        final uri =
            Uri.parse("https://api.cloudinary.com/v1_1/dwnafq5yb/image/upload");
        const uploadPreset = 'stubud';

        final request = http.MultipartRequest('POST', uri)
          ..fields['upload_preset'] = uploadPreset
          ..files
              .add(await http.MultipartFile.fromPath('file', imageFile.path));

        final response = await request.send();

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          final jsonResponse = jsonDecode(responseBody);

          final String imageUrl = jsonResponse['secure_url'];
          if (kDebugMode) {
            print("Image uploaded successfully: $imageUrl");
          }

          await _sendImageMessage(imageUrl);
        } else {
          if (kDebugMode) {
            print(
                "Failed to upload image. Status code: ${response.statusCode}");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("An error occurred: $e");
        }
      }
    } else {
      if (kDebugMode) {
        print("No image picked");
      }
    }
  }

  Future<void> _sendImageMessage(String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse('$flaskBaseUrl/send_image_message'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'chatID': widget.chatID,
          'senderID': widget.currentUserID,
          'imageUrl': imageUrl,
        }),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Image message sent successfully.");
        }
        _scrollToBottom();
      } else {
        throw Exception('Failed to send image message');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error sending image message: $e");
      }
    }
  }

  List<Map<String, dynamic>>? _messages;

  void _subscribeToMessages() {
  _messagesSubscription = FirebaseFirestore.instance
      .collection('ChatSessions')
      .doc(widget.chatID)
      .collection('Messages')
      .orderBy('timestamp')
      .snapshots()
      .listen(
    (snapshot) {
      final messages = snapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      if (mounted) {
        setState(() {
          _messages = messages;
        });

        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollToBottom();
        });
      }
    },
    onError: (error) {
      print('Error fetching messages: $error');
    },
  );
}

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      try {
        final receiverResponse = await http.get(
          Uri.parse(
              '$flaskBaseUrl/get_receiver_id?chatID=${widget.chatID}&senderID=${widget.currentUserID}'),
        );

        if (receiverResponse.statusCode == 200) {
          final receiverData = json.decode(receiverResponse.body);
          String receiverID = receiverData['receiverID'];

          final messageData = {
            'chatID': widget.chatID,
            'senderID': widget.currentUserID,
            'receiverID': receiverID,
            'message': _messageController.text,
            'isAudio': false,
            'isImage': false,
          };

          final response = await http.post(
            Uri.parse('$flaskBaseUrl/send_message'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(messageData),
          );

          if (response.statusCode == 200) {
            _messageController.clear();
          } else {
            throw Exception('Failed to send message');
          }
        } else {
          throw Exception('Failed to fetch receiverID');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error sending message: $e');
        }
      }
    }
  }

  Future<void> _markMessagesAsSeen() async {
    try {
      await http.post(
        Uri.parse('$flaskBaseUrl/mark_seen'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'chatID': widget.chatID,
          'receiverID': widget.currentUserID,
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error marking messages as seen: $e');
      }
    }
  }

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
                    Navigator.of(context).pushNamed("imad");
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
                    unfriendUser(context, widget.chatID, widget.currentUserID);
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
                    navigateToReport(
                        context, widget.chatID, widget.currentUserID);
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
    super.build(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: _showProfileDialog,
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://th.bing.com/th/id/R.d064a09d90d5c177c4813b582941c189?rik=oRNqtsfDamTI7Q&pid=ImgRaw&r=0"),
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        receiverName,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Height of the line
          child: Container(
            color: Colors.grey, // Line color
            height: 1.0, // Line thickness
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages == null
                ? const Center(child: CircularProgressIndicator())
                : _messages!.isEmpty
                    ? const Center(child: Text('No messages yet.'))
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages!.length,
                        itemBuilder: (context, index) {
                          final message = _messages![index];
                          final isSent =
                              message['senderID'] == widget.currentUserID;
                          final isImage = message['isImage'] ?? false;
                          final isLastMessage = index == _messages!.length - 1;
                          final isSeen = message['isSeen'] ?? false;

                          return Column(
                            crossAxisAlignment: isSent
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: isSent
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.0135,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: isSent
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (!isSent)
                                        const CircleAvatar(
                                          radius: 23,
                                          backgroundImage: NetworkImage(
                                            "https://th.bing.com/th/id/R.d064a09d90d5c177c4813b582941c189?rik=oRNqtsfDamTI7Q&pid=ImgRaw&r=0",
                                          ),
                                        ),
                                      if (!isSent)
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.009,
                                        ),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0395,
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0158,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0081,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSent
                                              ? const Color(0xFFE6EAF0)
                                              : const Color(0xFF7C90D6),
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
                                        child: isImage
                                            ? Image.network(
                                                message['message'],
                                                fit: BoxFit.cover,
                                              )
                                            : Text(
                                                message['message'] ?? '',
                                                style: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: isSent
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Display "Seen" or "Not Seen" below the last message sent by the user
                              if (isSent && isLastMessage)
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.0395,
                                    top: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  child: Text(
                                    isSeen ? 'Seen' : 'Not Seen',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 0,
                bottom: (screenHeight * 0.01),
                left: (screenWidth * 0.0168),
                right: (screenWidth * 0.0168)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showAttachmentOptions)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () =>
                              _pickImageAndUpload(ImageSource.camera),
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
                          onPressed: () =>
                              _pickImageAndUpload(ImageSource.gallery),
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
                      ],
                    ),
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
                                controller: _messageController,
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
                              onPressed: _sendMessage,
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

  @override
  bool get wantKeepAlive => true;
}
