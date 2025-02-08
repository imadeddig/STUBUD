import 'package:stubudmvp/services/database/StudentProfile.dart';



// Function to print the content of the StudentProfile table
Future<void> printStudentProfiles() async {
  try {
    // Fetch all student profiles from the database
    List<Map<String, dynamic>> studentProfiles = await StudentProfileDB.getStudentProfiles();

    if (studentProfiles.isNotEmpty) {
      print('Student Profiles:');
      // Iterate through each profile and print its content
      for (var profile in studentProfiles) {
        print('UserID: ${profile['userID']}');
        print('Email: ${profile['email']}');
        print('Username: ${profile['username']}');
        print('Gender: ${profile['gender']}');
        print('Date of Birth: ${profile['dateOfBirth']}');
        print('School: ${profile['school']}');
        print('Field: ${profile['field']}');
        print('Speciality: ${profile['speciality']}');
        print('Level: ${profile['level']}');
        print('Location: ${profile['location']}');
        print('Phone Number: ${profile['phoneNumber']}');
        print('Bio: ${profile['bio']}');
        print('---------------------------');
      }
    } else {
      print('No student profiles found.');
    }
  } catch (error) {
    print('Error occurred while fetching student profiles: $error');
  }
}
