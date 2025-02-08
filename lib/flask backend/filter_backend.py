from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials, firestore, messaging
from geopy.distance import geodesic
from datetime import datetime
from flask_cors import CORS
from geopy.geocoders import Nominatim  # Import Nominatim

# Initialize Flask app
app = Flask(__name__)
# Initialize Firebase

geolocator = Nominatim(user_agent="stubud_app")

def get_location_name(latitude, longitude):
    try:
        location = geolocator.reverse((latitude, longitude), exactly_one=True)
        if location:
            return location.address
        else:
            return "Location not found"
    except Exception as e:
        print(f"Error fetching location name: {e}")
        return "Location not available"



@app.route('/test-endpoint', methods=['GET'])
def test_endpoint():
    try:
        print('we good')
        # Return a simple test message
        return jsonify({'message': 'Test successful!'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    


@app.route('/test-connection', methods=['GET'])
def test_connection():
    return jsonify({"message": "Connection successful!"}), 200


print('hello before ')


@app.route('/fetch-students', methods=['POST'])
def fetch_users():
    print("Raw request data:", request.get_data(as_text=True))
    print("Parsed JSON data:", request.json)

    # Get the JSON data from the request body
    request_data = request.json
    user_id = request_data.get('userID') if request_data.get('userID') else None
    applied_filters = request_data.get('appliedFilters', {})  # Default to empty dict if nul
    max_distance = 30

    print("filters are")
    print(applied_filters)

    try:
        # Fetch the logged-in user's document
        logged_in_user_doc = db.collection('users').document(user_id).get()
        if not logged_in_user_doc.exists:
            return jsonify({"error": "Logged-in user document not found"}), 404

        # Extract friends list and location
        user_data = logged_in_user_doc.to_dict()
        friends = user_data.get('friends', [])
        current_user_location = user_data.get('location')
        current_user_interests = user_data.get('interests', [])
        current_user_languages = user_data.get('languagesSpoken', [])
        current_user_study_methods = user_data.get('preferredStudyMethods', [])
        current_user_study_times = user_data.get('preferredStudyTimes', [])
        current_user_goals = user_data.get('studyGoals', [])
        current_user_communication_methods = user_data.get('communicationMethods', [])
        # Initialize query to fetch all users
        query = db.collection('users')

        # Apply filters to the query
        if applied_filters.get('gender'):
            query = query.where('gender', '==', applied_filters['gender'])

        if applied_filters.get('selectedStudyMethods'):
            query = query.where('preferredStudyMethods', 'array_contains_any', applied_filters['selectedStudyMethods'])

        if applied_filters.get('selectedStudyTimes'):
            query = query.where('preferredStudyTimes', 'array_contains_any', applied_filters['selectedStudyTimes'])

        if applied_filters.get('selectedGoals'):
            query = query.where('studyGoals', 'array_contains_any', applied_filters['selectedGoals'])

        if applied_filters.get('selectedCommunicationMethods'):
            query = query.where('communicationMethods', 'array_contains_any', applied_filters['selectedCommunicationMethods'])

        if applied_filters.get('languages'):
            query = query.where('languagesSpoken', 'array_contains_any', applied_filters['languages'])

        if applied_filters.get('interests'):
            query = query.where('interests', 'array_contains_any', applied_filters['interests'])

        # Fetch all users based on the query
        snapshot = query.get()
        users = []

        # Process each user
        for doc in snapshot:
            if doc.id != user_id and doc.id not in friends:
                user_data = doc.to_dict()

                # Calculate age from dateOfBirth
                age = None
                if 'dateOfBirth' in user_data and user_data['dateOfBirth']:
                    date_of_birth = user_data['dateOfBirth']
                    if isinstance(date_of_birth, datetime):
                        now = datetime.now()
                        age = now.year - date_of_birth.year
                        if (now.month, now.day) < (date_of_birth.month, date_of_birth.day):
                            age -= 1

                # Calculate distance between users
                distance = None
                location_name = None 
                if current_user_location and 'location' in user_data:
                    try:
                        current_user_lat = current_user_location.latitude
                        current_user_lon = current_user_location.longitude
                        other_user_lat = user_data['location'].latitude
                        other_user_lon = user_data['location'].longitude

                        # Calculate distance in kilometers
                        distance = geodesic(
                            (current_user_lat, current_user_lon),
                            (other_user_lat, other_user_lon)
                        ).kilometers
                        location_name = get_location_name(other_user_lat, other_user_lon)
                    except AttributeError:
                        pass
                if distance is not None and distance > max_distance:
                    continue

                similarity_score = 0
                other_user_interests = user_data.get('interests', [])
                other_user_languages = user_data.get('languagesSpoken', [])
                other_user_study_methods = user_data.get('preferredStudyMethods', [])
                other_user_study_times = user_data.get('preferredStudyTimes', [])
                other_user_goals = user_data.get('studyGoals', [])
                other_user_communication_methods = user_data.get('communicationMethods', [])

                # Add points for common interests, languages, etc.
                similarity_score += len(set(current_user_interests).intersection(other_user_interests))
                similarity_score += len(set(current_user_languages).intersection(other_user_languages))
                similarity_score += len(set(current_user_study_methods).intersection(other_user_study_methods))
                similarity_score += len(set(current_user_study_times).intersection(other_user_study_times))
                similarity_score += len(set(current_user_goals).intersection(other_user_goals))
                similarity_score += len(set(current_user_communication_methods).intersection(other_user_communication_methods))                
                # Add user data to the list
                users.append({
                    'userID': doc.id,
                    'name': user_data.get('fullName'),
                    'bio': user_data.get('bio'),
                    'detail': f"Student at {user_data.get('school')}",
                    'image': user_data.get('profilePic', 'default_image.jpg'),
                    'interests': user_data.get('interests', []),
                    'academicStrengths': user_data.get('academicStrengths', []),
                    'languagesSpoken': user_data.get('languagesSpoken', []),
                    'communicationMethods': user_data.get('communicationMethods', []),
                    'preferredStudyMethods': user_data.get('preferredStudyMethods', []),
                    'preferredStudyTimes': user_data.get('preferredStudyTimes', []),
                    'studyGoals': user_data.get('studyGoals', []),
                    'values': user_data.get('values', []),
                    'images': user_data.get('images', []),
                    'imagesSize': len(user_data.get('images', [])),
                    'dateOfBirth': user_data.get('dateOfBirth'),
                    'age': age,
                    'distance': distance,
                    'similarity_score': similarity_score,
                    'locationName': location_name,
                })
             

        # Apply age range filter
        if 'ageRange' in applied_filters:
            min_age = applied_filters['ageRange']['start']
            max_age = applied_filters['ageRange']['end']
            users = [user for user in users if user['age'] is not None and min_age <= user['age'] <= max_age]

        # Apply distance filter
        if applied_filters.get('distance'):
            max_distance = applied_filters['distance']
            users = [user for user in users if user['distance'] is not None and user['distance'] <= max_distance]

        users.sort(key=lambda x: (-x['similarity_score'], x['distance'] if x['distance'] is not None else float('inf')))   
        # Debugging: Print final filtered users
        print("Final filtered users:", users)

        # Return the filtered list of users
        return jsonify(users), 200

    except Exception as e:
        # Handle any errors
        return jsonify({"error": str(e)}), 500


@app.route('/swipe', methods=['POST'])
def handle_swipe():
    try:
        # Get the JSON data from the request body
        request_data = request.json
        current_user_id = request_data.get('currentUserId')
        other_user_id = request_data.get('otherUserId')

        if not current_user_id or not other_user_id:
            return jsonify({"error": "Missing currentUserId or otherUserId"}), 400

        # Reference to the "InterestedIn" collection
        interested_in_ref = db.collection('InterestedIn')

        # Check if the other user has already swiped on the current user
        current_user_swipe = interested_in_ref \
            .where('InterestedStuID', '==', other_user_id) \
            .where('RecipientStuID', '==', current_user_id) \
            .get()

        is_match = False
        token1 = ''
        token2 = ''

        if len(current_user_swipe) > 0:
            # Match found, update the friends list for both users
            db.collection('users').document(current_user_id).update({
                'friends': firestore.ArrayUnion([other_user_id])
            })
            db.collection('users').document(other_user_id).update({
                'friends': firestore.ArrayUnion([current_user_id])
            })


            current_user_doc = db.collection('users').document(current_user_id).get()
            other_user_doc = db.collection('users').document(other_user_id).get()

            if current_user_doc.exists and 'token' in current_user_doc.to_dict():
                token1 = current_user_doc.to_dict()['token']

            if other_user_doc.exists and 'token' in other_user_doc.to_dict():
                token2 = other_user_doc.to_dict()['token']
            # Remove the swipe document to complete the match process
            interested_in_ref.document(current_user_swipe[0].id).delete()
            is_match = True

            if token1:
                message = messaging.Message(notification=messaging.Notification( title='It is a Match!',body='You have made a new Study Buddy, Start Chatting now!' ),token=token1)
                response1 = messaging.send(message)
                print(f'Successfully sent message to  users: {response1}')
            if token2:
                message = messaging.Message(notification=messaging.Notification( title='It is a Match!',body='You have made a new Study Buddy, Start Chatting now!' ),token=token2)
                response = messaging.send(message)       
        else:
            # No match yet, add a swipe record
            interested_in_ref.add({
                'InterestedStuID': current_user_id,
                'RecipientStuID': other_user_id,
                'matchDate': firestore.SERVER_TIMESTAMP
            })

        # Add the swipe to the current user's slides
        db.collection('users').document(current_user_id).update({
            'slides': firestore.ArrayUnion([other_user_id])
        })

        # Return the result (whether a match occurred or not)
        return jsonify({"isMatch": is_match}), 200

    except Exception as e:
        print(f'Error processing swipe: {e}')
        return jsonify({"error": str(e)}), 500



