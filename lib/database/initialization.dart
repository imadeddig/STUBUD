import 'package:stubudmvp/database/StudentProfile.dart';
import 'package:stubudmvp/database/chatSession.dart';

List<Map<String, dynamic>> studentProfiles = [
  {
    'userID': '1',
    'email': 'student1@example.com',
    'username': 'Student1',
    'password': 'password123',
    'gender': 'Female',
    'dateOfBirth': '1999-03-15',
    'school': 'Sample School',
    'wilaya': 'Sample Wilaya',
    'field': 'Engineering',
    'speciality': 'Electrical Engineering',
    'level': 'Undergraduate',
    'location': 'Sample Location 1',
    'phoneNumber': '1234567891',
    'bio': 'This is a bio for student 1.',
    'profilePicture': 'https://example.com/profile1.jpg',
  },
  {
    'userID': '2',
    'email': 'student2@example.com',
    'username': 'Student2',
    'password': 'password123',
    'gender': 'Male',
    'dateOfBirth': '2000-01-01',
    'school': 'Sample School',
    'wilaya': 'Sample Wilaya',
    'field': 'Engineering',
    'speciality': 'Computer Science',
    'level': 'Undergraduate',
    'location': 'Sample Location 2',
    'phoneNumber': '1234567890',
    'bio': 'This is a bio for student 2.',
    'profilePicture': 'https://example.com/profile2.jpg',
  },
  {
    'userID': '3',
    'email': 'student3@example.com',
    'username': 'Student3',
    'password': 'password123',
    'gender': 'Female',
    'dateOfBirth': '1998-07-21',
    'school': 'Sample School',
    'wilaya': 'Sample Wilaya',
    'field': 'Engineering',
    'speciality': 'Mechanical Engineering',
    'level': 'Undergraduate',
    'location': 'Sample Location 3',
    'phoneNumber': '1234567892',
    'bio': 'This is a bio for student 3.',
    'profilePicture': 'https://example.com/profile3.jpg',
  },
  {
    'userID': '4',
    'email': 'student4@example.com',
    'username': 'Student4',
    'password': 'password123',
    'gender': 'Male',
    'dateOfBirth': '1997-09-10',
    'school': 'Sample School',
    'wilaya': 'Sample Wilaya',
    'field': 'Engineering',
    'speciality': 'Civil Engineering',
    'level': 'Postgraduate',
    'location': 'Sample Location 4',
    'phoneNumber': '1234567893',
    'bio': 'This is a bio for student 4.',
    'profilePicture': 'https://example.com/profile4.jpg',
  },
];


Future<void> initializeData() async {

    for (var studentProfile in studentProfiles) {
      int userId = await StudentProfileDB.insertStudentProfile(studentProfile);
      print('Inserted student with ID: $userId');
    }


 await ChatSessionsDB.insertChatSession(
      user1ID: 1, // Always user1ID = 1
      user2ID: 2, // user2ID = 2 (first chat)
      lastMessage: 'Are you down to study at this cool place I found?', // Sample message
    );
    print('Inserted chat session between user1 (ID: 1) and user2 (ID: 2)');
    
    await ChatSessionsDB.insertChatSession(
      user1ID: 1, // Always user1ID = 1
      user2ID: 3, // user2ID = 3 (second chat)
      lastMessage: 'Are you down to study at this cool place I found?', // Sample message
    );
    print('Inserted chat session between user1 (ID: 1) and user2 (ID: 3)');
    
    await ChatSessionsDB.insertChatSession(
      user1ID: 1, // Always user1ID = 1
      user2ID: 4, // user2ID = 4 (third chat)
      lastMessage: 'Are you down to study at this cool place I found?', // Sample message
    );
    print('Inserted chat session between user1 (ID: 1) and user2 (ID: 4)');
    
}

