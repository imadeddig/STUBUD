import 'package:geolocator/geolocator.dart';

Future<void> _fetchData({Map<String, dynamic>? appliedFilters}) async  {
  setState(() {
    _isLoading = true; // Show loading indicator while fetching data
  });
  int minAge = -1;
  int maxAge = -1;

  try {
    final loggedInUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userID)
        .get();
    if (!loggedInUserDoc.exists) {
      throw Exception("Logged-in user document not found");
    }

    List<String> friends =
        List<String>.from(loggedInUserDoc.data()?['friendsList'] ?? []);
    final currentUserLocation = loggedInUserDoc.data()?['location'];

    Query query = FirebaseFirestore.instance.collection('users');

    if (appliedFilters != null) {
      if (appliedFilters.containsKey('gender') &&
          appliedFilters['gender'].isNotEmpty) {
        query = query.where('gender', isEqualTo: appliedFilters['gender']);
      }
      if (appliedFilters.containsKey('ageRange')) {
        final RangeValues ageRange = appliedFilters['ageRange']; 
        minAge = ageRange.start.toInt();
        maxAge = ageRange.end.toInt();
      }
    }

    final snapshot = await query.get();
    final documents = snapshot.docs.where((doc) {
      return doc.id != widget.userID && !friends.contains(doc.id);
    }).toList();

    _users = documents.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      // Convert Firestore Timestamp to DateTime
      DateTime? dateOfBirth;
      int? age;
      if (data.containsKey('dateOfBirth') && data['dateOfBirth'] != null) {
        dateOfBirth = (data['dateOfBirth'] as Timestamp).toDate();

        // Calculate age if dateOfBirth is valid
        final now = DateTime.now();
        age = now.year - dateOfBirth.year;

        // Adjust age if the birthday hasn't occurred yet this year
        if (now.month < dateOfBirth.month || 
            (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
          age--;
        }
      }

      // Calculate distance if location data exists
      double? distance;
      if (currentUserLocation != null && data['location'] != null) {
        final currentUserGeoPoint = currentUserLocation as GeoPoint;
        final otherUserGeoPoint = data['location'] as GeoPoint;

        // Calculate the distance between the two locations in meters
        distance = await Geolocator.distanceBetween(
          currentUserGeoPoint.latitude,
          currentUserGeoPoint.longitude,
          otherUserGeoPoint.latitude,
          otherUserGeoPoint.longitude,
        );
      }

      return {
        'userID': doc.id,
        'name': data['fullName'],
        'bio': data['bio'],
        'detail': 'Student at ${data['school']}',
        'image': data['profilePic'] ?? 'default_image.jpg',
        'interests': data['interests'] ?? [],
        'academicStrengths': data['academic strengths'] ?? [],
        'languagesSpoken': data['languagesSpoken'] ?? [],
        'communicationMethods': data['communicationMethods'] ?? [],
        'preferredStudyMethods': data['preferredStudyMethods'] ?? [],
        'preferredStudyTimes': data['preferredStudyTimes'] ?? [],
        'studyGoals': data['studyGoals'] ?? [],
        'values': data['values'] ?? [],
        'images': data['images'] ?? [],
        'imagesSize': (data['images'] ?? []).length,
        'dateOfBirth': data['dateOfBirth'] ?? [],
        'age': age,
        'distance': distance ?? 0.0, // Add distance field
      };
    }).toList();
  } catch (e) {
    print('Error fetching data: $e');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }

  if (minAge > 0 && maxAge > 0) {
    _users = _users.where((user) {
      return user['age'] >= minAge && user['age'] <= maxAge;
    }).toList();
  }

  print(_users);
  print('after getting data from database, users list length is ${_users.length}');
  if (_users.isEmpty) {
    noMoreUsers = true;
  }
}
