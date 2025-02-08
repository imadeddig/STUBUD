import hashlib
import os
from flask import Flask, request, jsonify
import datetime
import random
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import smtplib
import re
from google.cloud import firestore
import firebase_admin
from firebase_admin import credentials
from firebase_admin import initialize_app
from werkzeug.security import generate_password_hash

from enum import auto
import string
from flask import Flask, jsonify , request , Response
from google.cloud import firestore
from firebase_admin import credentials, initialize_app
import os
from google.cloud.firestore_v1 import GeoPoint
from flask_cors import CORS
import hashlib


import datetime
import random
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import smtplib
import re
from google.cloud import firestore
import logging
from geopy.geocoders import Nominatim
from werkzeug.security import generate_password_hash
import filter_backend
# Initialize Flask app
app = Flask(__name__)

# Email verification database (temporary in-memory storage)
email_verification_db = {}


db = firestore.Client.from_service_account_json(r'C:\Users\Sphere\OneDrive\Bureau\studBud project\STUBUD\lib\flask backend\serviceAccountKey.json')



@app.route('/get_chats/<user_id>', methods=['GET'])
def get_chats(user_id):
    try:
        
        chats1 = db.collection('ChatSessions').where('user1ID', '==', user_id).stream()
        chats2 = db.collection('ChatSessions').where('user2ID', '==', user_id).stream()

        chats = []
        for chat in chats1:
            chat_data = chat.to_dict()
            chat_data['id'] = chat.id
            chats.append(chat_data)

        for chat in chats2:
            chat_data = chat.to_dict()
            chat_data['id'] = chat.id
            chats.append(chat_data)

        
        unique_chats = {chat['id']: chat for chat in chats}.values()
        sorted_chats = sorted(
            unique_chats, key=lambda x: x.get('lastMessageTime', None), reverse=True
        )

        return jsonify(list(sorted_chats)), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route('/get_user/<user_id>', methods=['GET'])
def get_user(user_id):
    try:
        user_doc = db.collection('users').document(user_id).get()
        if user_doc.exists:
            user_data = user_doc.to_dict()
            
          
            for key, value in user_data.items():
                if isinstance(value, GeoPoint):
                    user_data[key] = {
                        'latitude': value.latitude,
                        'longitude': value.longitude
                    }
            
            return jsonify(user_data), 200
        else:
            return jsonify({'error': 'User not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route('/create_chat', methods=['POST'])
def create_chat():
    try:
        data = request.get_json()
        user1_id = data['user1ID']
        user2_id = data['user2ID']

        chat_ref = db.collection('ChatSessions').document()
        chat_ref.set({
            'user1ID': user1_id,
            'user2ID': user2_id,
            'lastMessage': '',
            'lastMessageSender': '',
            'lastMessageTime': firestore.SERVER_TIMESTAMP,
        })

        return jsonify({'id': chat_ref.id}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500





@app.route('/get_messages/<chat_id>', methods=['GET'])
def get_messages(chat_id):
    try:
        
        messages_ref = db.collection('ChatSessions').document(chat_id).collection('Messages')
        messages_query = messages_ref.order_by('timestamp').stream()

        
        messages = []
        for message in messages_query:
            message_data = message.to_dict()
            message_data['id'] = message.id 
            messages.append(message_data)

        return jsonify(messages), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route('/mark_seen', methods=['POST'])
def mark_seen():
    try:
        data = request.get_json()
        chat_id = data['chatID']
        receiver_id = data['receiverID']

        messages = db.collection('ChatSessions').document(chat_id).collection('Messages').where('receiverID', '==', receiver_id).where('isSeen', '==', False).stream()
        for message in messages:
            message.reference.update({'isSeen': True})
        
        return jsonify({'status': 'success'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/send_message', methods=['POST'])
def send_message():
    try:
        data = request.get_json()
        chat_id = data['chatID']
        sender_id = data['senderID']
        receiver_id = data['receiverID']  
        message = data['message']
        isAudio = data["isAudio"]
        isImage = data["isImage"]
        

        chat_ref = db.collection('ChatSessions').document(chat_id)
        chat_ref.collection('Messages').add({
            'senderID': sender_id,
            'receiverID': receiver_id,  
            'message': message,
            'timestamp': firestore.SERVER_TIMESTAMP,
            'isSeen': False,
            "isAudio" : isAudio , 
            "isImage" : isImage , 

            
        })
        chat_ref.update({
            'lastMessage': message,
            'lastMessageSender': sender_id,
            'lastMessageReceiver': receiver_id,  
            'lastMessageTime': firestore.SERVER_TIMESTAMP,
        })

        return jsonify({'status': 'success'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/get_receiver_id', methods=['GET'])
def get_receiver_id():
    try:
        chat_id = request.args.get('chatID') 
        sender_id = request.args.get('senderID')  

    
        chat_ref = db.collection('ChatSessions').document(chat_id)
        chat_doc = chat_ref.get()

        if chat_doc.exists:
            chat_data = chat_doc.to_dict()

            
            user1ID = chat_data['user1ID']
            user2ID = chat_data['user2ID']

            
            receiver_id = user1ID if sender_id != user1ID else user2ID

            
            return jsonify({'receiverID': receiver_id}), 200
        else:
            return jsonify({'error': 'Chat not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/send_image_message', methods=['POST'])
def send_image_message():
    try:
        data = request.get_json()
        chat_id = data['chatID']
        sender_id = data['senderID']
        image_url = data['imageUrl']

        
        chat_ref = db.collection('ChatSessions').document(chat_id)
        chat_doc = chat_ref.get()

        if chat_doc.exists:
            chat_data = chat_doc.to_dict()
            user1ID = chat_data['user1ID']
            user2ID = chat_data['user2ID']
            receiver_id = user1ID if sender_id == user2ID else user2ID

          
            chat_ref.collection('Messages').add({
                'senderID': sender_id,
                'receiverID': receiver_id,
                'message': image_url,
                'isImage': True,
                'timestamp': firestore.SERVER_TIMESTAMP,
                'isAudio': False,
                'isSeen': False,
            })

          
            chat_ref.update({
                'lastMessage': "[Image]",
                'lastMessageSender': sender_id,
                'lastMessageTime': firestore.SERVER_TIMESTAMP,
            })

            return jsonify({'status': 'success'}), 200
        else:
            return jsonify({'error': 'Chat session not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route('/get_interests', methods=['GET'])
def get_interests():
    try:

        doc_ref = db.collection('Interests').document('interest')
        doc_snapshot = doc_ref.get()

        if doc_snapshot.exists:
            interests_data = doc_snapshot.to_dict()
          
            interests_array = interests_data.get('interest1', [])
            if isinstance(interests_array, list):
                return jsonify({'interests': interests_array}), 200
            else:
                return jsonify({'error': 'Invalid data format for interests'}), 400
        else:
            return jsonify({'error': 'Interests document not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    


@app.route('/get_interests2', methods=['GET'])
def get_interests2():
    try:
      
        doc_snapshot = db.collection('Interests').document('interest').get()
        if doc_snapshot.exists:
            data = doc_snapshot.to_dict()
            interests = data.get('interest2', [])
            return jsonify({'interests': interests}), 200
        else:
            return jsonify({'error': 'Document not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    

@app.route('/get_languages', methods=['GET'])
def get_languages():
    try:
      
        doc_snapshot = db.collection('Interests').document('interest').get()
        if doc_snapshot.exists:
            data = doc_snapshot.to_dict()
            languages = data.get('interest3', [])  
            return jsonify({'languages': languages}), 200
        else:
            return jsonify({'error': 'Document not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/unfriend', methods=['POST'])
def unfriend():
    try:
        data = request.json
        chat_id = data.get('chatID')
        current_user_id = data.get('currentUserID')
        
        if not chat_id or not current_user_id:
            return jsonify({'error': 'Missing required fields'}), 400

        # Get the chat session
        chat_ref = db.collection('ChatSessions').document(chat_id)
        chat_doc = chat_ref.get()
        
        if not chat_doc.exists:
            return jsonify({'error': 'Chat session not found'}), 404

        chat_data = chat_doc.to_dict()
        
        # Determine the receiver ID
        user1_id = chat_data.get('user1ID')
        user2_id = chat_data.get('user2ID')
        receiver_id = user1_id if user2_id == current_user_id else user2_id

        # Remove receiver ID from current user's friends list
        user_ref = db.collection('users').document(current_user_id)
        user_ref.update({"friends": firestore.ArrayRemove([receiver_id])})

        # Remove current user ID from receiver's friends list
        receiver_ref = db.collection('users').document(receiver_id)
        receiver_ref.update({"friends": firestore.ArrayRemove([current_user_id])})
        
        # Delete the chat session
        chat_ref.delete()
        
        return jsonify({'message': 'Unfriended successfully'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# Generate a random verification code
def generate_verification_code(length=5):
    characters = string.digits
    return ''.join(random.choice(characters) for i in range(length))


def validate_email(email):
    # Regex pattern to extract the domain from the email
    email_regex = r'^[a-zA-Z0-9._%+-]+@([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$'
    match = re.match(email_regex, email)
    
    if not match:
        return False  # Invalid email format
    
    domain = match.group(1)  # Extract domain part from email
    # Fetch allowed domains from Firestore
    allowed_domains_ref = db.collection('institutions').stream()
    allowed_domains = {doc.to_dict().get('Email').split('@')[1] for doc in allowed_domains_ref if 'Email' in doc.to_dict()}
    print(allowed_domains)
    if domain in allowed_domains:
        return True  # Domain is valid
    return False  # Domain is not allowed

@app.route('/validate_email', methods=['POST'])
def email_validation():
    try:
        # Get email from the request
        data = request.get_json()
        email = data.get('email')
        
        if not email:
            return jsonify({'error': 'Email is required'}), 400
        
        # Validate email
        is_valid = validate_email(email)
        
        if is_valid:
            return jsonify({'message': 'Email is valid'}), 200
        else:
            return jsonify({'error': 'Invalid email domain'}), 400

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    

@app.route('/get_username/<user_id>', methods=['GET'])
def get_username(user_id):
    try:
        user_ref = db.collection('users').document(user_id)
        user_doc = user_ref.get()
        
        if user_doc.exists:
            user_data = user_doc.to_dict()
            return jsonify({"username": user_data.get('username', ''), "lastUpdated": user_data.get('lastUsernameUpdate', None)}), 200
        else:
            return jsonify({"error": "User not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/update_username', methods=['POST'])
def update_username():
    try:
        data = request.json
        user_id = data['userID']
        new_username = data['username']

        # Check if the username already exists
        query = db.collection('users').where('username', '==', new_username).stream()
        if any(query):
            return jsonify({"error": "Username already exists"}), 400

        user_ref = db.collection('users').document(user_id)
        user_doc = user_ref.get()

        if user_doc.exists:
            user_data = user_doc.to_dict()
            last_updated = user_data.get('lastUsernameUpdate', None)

            if last_updated:
                from datetime import datetime, timezone
                last_updated = last_updated.replace(tzinfo=timezone.utc)
                current_time = datetime.now(timezone.utc)
                if (current_time - last_updated).days < 60:
                    return jsonify({"error": "Username can only be updated once every 2 months"}), 400

        # Update the username
        user_ref.update({
            'username': new_username,
            'lastUsernameUpdate': firestore.SERVER_TIMESTAMP
        })

        return jsonify({"message": "Username updated successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/change_password', methods=['POST'])
def change_password():
    try:
        def hash_password(password):
            hashed = hashlib.sha256(password.encode('utf-8')).hexdigest()
            return hashed
        # Get request data
        data = request.get_json()
        user_id = data['userID']
        current_password = data['currentPassword']
        new_password = data['newPassword']

        # Fetch the user document from Firestore
        user_ref = db.collection('users').document(user_id)
        user_doc = user_ref.get()

        if not user_doc.exists:
            return jsonify({'error': 'User not found.'}), 404

        user_data = user_doc.to_dict()
        stored_password = user_data['password']

        # Check if the current password matches the stored password
        if hash_password(current_password) != stored_password:
            return jsonify({'error': 'Current password is incorrect.'}), 400

        # Update the password in Firestore
        user_ref.update({'password': hash_password(new_password)})

        return jsonify({'message': 'Password updated successfully!'}), 200

    except Exception as e:
        return jsonify({'error': f"An error occurred: {str(e)}"}), 500
    
# Initialize Firebase Admin SDK
cred = credentials.Certificate(r'C:\Users\Sphere\OneDrive\Bureau\studBud project\STUBUD\lib\flask backend\serviceAccountKey.json')
initialize_app(cred)

@app.route('/update_phone_number', methods=['POST'])
def update_phone_number():
    try:
        # Get request data
        data = request.get_json()
        user_id = data['userId']
        phone_number = data['phoneNumber']

        # Validate phone number format (Optional)
        if not phone_number.isdigit() or len(phone_number) < 10 or len(phone_number) > 15:
            return jsonify({'error': 'Invalid phone number format'}), 400

        # Update the phone number in Firestore
        user_ref = db.collection('users').document(user_id)
        user_ref.update({'phoneNumber': phone_number})

        return jsonify({'message': 'Phone number updated successfully!'}), 200

    except Exception as e:
        return jsonify({'error': f"An error occurred: {str(e)}"}), 500


@app.route('/send_verification_email', methods=['POST'])
def send_verification_email():
    try:
        # Get request data
        data = request.get_json()
        email = data['email']

        # Send email verification using Firebase Authentication
        user = auth.get_user_by_email(email)
        auth.send_email_verification(user.uid)

        return jsonify({'message': 'Verification email sent successfully!'}), 200

    except Exception as e:
        return jsonify({'error': f"An error occurred: {str(e)}"}), 500
@app.route('/report_user', methods=['POST'])
def report_user():
    try:
        data = request.get_json()
        who_reported_id = data['whoReportedId']
        reported_user_id = data['reportedUserId']
        report_details = data['reportDetails']

        # Add report to Firestore
        report_ref = db.collection('reports').add({
            'whoReportedId': who_reported_id,
            'reportedUserId': reported_user_id,
            'reportDetails': report_details,
            'timestamp': firestore.SERVER_TIMESTAMP
        })

        return jsonify({'reportId': report_ref.id}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 400

@app.route('/block_user', methods=['POST'])
def block_user():
    try:
        data = request.get_json()
        current_user_id = data['currentUserId']
        blocked_user_id = data['blockedUserId']

        # Add blocked user to Firestore
        db.collection('users').document(current_user_id).collection('blockedUsers').document(blocked_user_id).set({
            'timestamp': firestore.SERVER_TIMESTAMP
        })
        # Remove receiver ID from current user's friends list
        user_ref = db.collection('users').document(current_user_id)
        user_ref.update({"friends": firestore.ArrayRemove([blocked_user_id ])})

        # Remove current user ID from receiver's friends list
        receiver_ref = db.collection('users').document(blocked_user_id )
        receiver_ref.update({"friends": firestore.ArrayRemove([current_user_id])})
        return jsonify({'message': 'User blocked successfully'}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 400


@app.route('/unblock_user', methods=['POST'])
def unblock_user():
    try:
        data = request.get_json()
        current_user_id = data['currentUserId']
        blocked_user_id = data['blockedUserId']

        # Remove blocked user from Firestore
        db.collection('users').document(current_user_id).collection('blockedUsers').document(blocked_user_id).delete()
        user_ref = db.collection('users').document(current_user_id)
        user_ref.update({"friends": firestore.ArrayUnion([blocked_user_id ])})

        # Remove current user ID from receiver's friends list
        receiver_ref = db.collection('users').document(blocked_user_id )
        receiver_ref.update({"friends": firestore.ArrayUnion([current_user_id])})
        # Fetch updated blocked users list after unblocking
        blocked_users_ref = db.collection('users').document(current_user_id).collection('blockedUsers')
        blocked_users = blocked_users_ref.get()

        blocked_users_list = []
        for user in blocked_users:
            user_doc = db.collection('users').document(user.id).get()
            if user_doc.exists:
                user_data = user_doc.to_dict() or {}
                blocked_users_list.append({
                    'userId': user.id,
                    'fullName': user_data.get('fullName', 'Unknown'),
                    'username': user_data.get('username', 'Unknown')
                })

        return jsonify({'message': 'User unblocked successfully', 'blockedUsers': blocked_users_list}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 400
    
@app.route('/get_blocked_users/<user_id>', methods=['GET'])
def get_blocked_users(user_id):
    try:
        # Fetch blocked users synchronously
        blocked_users_ref = db.collection('users').document(user_id).collection('blockedUsers')
        blocked_users = blocked_users_ref.get()  # Use get() instead of stream()

        blocked_users_list = []
        for user in blocked_users:
            user_doc = db.collection('users').document(user.id).get()
            if user_doc.exists:
                user_data = user_doc.to_dict() or {}
                blocked_users_list.append({
                    'userId': user.id,
                    'fullName': user_data.get('fullName', 'Unknown'),
                    'username': user_data.get('username', 'Unknown')
                })

        return jsonify(blocked_users_list), 200

    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': str(e)}), 400
    

from google.cloud import firestore
import hashlib
from flask import request, jsonify
import logging

# Move the helper function outside the login route
def geo_point_to_dict(geo_point):
    """Helper function to convert GeoPoint to dict."""
    if isinstance(geo_point, firestore.GeoPoint):
        return {
            "latitude": geo_point.latitude,
            "longitude": geo_point.longitude
        }
    return geo_point  # If it's not a GeoPoint, return it as is

@app.route('/login', methods=['POST'])
def login():
    try:
        data = request.get_json()
        email_or_username = data.get('emailOrUsername')
        password = data.get('password')

        def hash_password(password):
            hashed = hashlib.sha256(password.encode('utf-8')).hexdigest()
            return hashed

        if not email_or_username or not password:
            return jsonify({'error': 'Missing email/username or password'}), 400

        # Check Firestore for user by email
        users_ref = db.collection('users')
        query = users_ref.where('email', '==', email_or_username).stream()
        user_doc = next(query, None)

        if not user_doc:
            # If not found by email, check by username
            query = users_ref.where('username', '==', email_or_username).stream()
            user_doc = next(query, None)

        if user_doc:
            user_data = user_doc.to_dict()
            stored_hashed_password = user_data.get('password')  # Get stored hashed password

            if stored_hashed_password == hash_password(password):  # Compare hashed passwords
                # Convert GeoPoint fields to dictionary (if any)
                # Ensure only GeoPoint values are passed to the helper function
                user_data = {key: geo_point_to_dict(value) if isinstance(value, firestore.GeoPoint) else value for key, value in user_data.items()}

                return jsonify({
                    'message': 'Login successful',
                    'userID': user_doc.id,
                    'userData': user_data
                }), 200
            else:
                return jsonify({'error': 'Incorrect password'}), 401

        return jsonify({'error': 'Incorrect email/username'}), 404

    except Exception as e:
        logging.error(f"🔥 Error in login: {str(e)}", exc_info=True)
        return jsonify({'error': str(e)}), 500


@app.route("/fetch_user_interests", methods=["GET"])
def fetch_user_interests():
    try:
        user_id = request.args.get("userID")  # Get user ID from request parameters
        if not user_id:
            return jsonify({"error": "Missing userID"}), 400

        user_ref = db.collection("users").document(user_id)
        user_doc = user_ref.get()

        if user_doc.exists:
            user_data = user_doc.to_dict()

            return jsonify({
                "interest": user_data.get("interests", ["nothing"]),
                "values": user_data.get("values", ["nothing"]),
                "languages": user_data.get("languagesSpoken", ["nothing"]),
                "studyGoals": user_data.get("studyGoals", ["nothing"]),
                "preferredStudyTimes": user_data.get("preferredStudyTimes", ["nothing"]),
                "preferredStudyMethods": user_data.get("preferredStudyMethods", ["nothing"]),
                "skills": user_data.get("skills", ["nothing"]),
                "academicStrengths": user_data.get("academicStrengths", ["nothing"]),
                "communication": user_data.get("communicationMethods", ["nothing"]),
            }), 200

        else:
            return jsonify({"error": "User not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/fetch_info", methods=["GET"])
def fetch_info():
    try:
        user_id = request.args.get("userID")
        if not user_id:
            return jsonify({"error": "Missing userID"}), 400

        user_ref = db.collection("users").document(user_id)
        user_doc = user_ref.get()

        if user_doc.exists:
            user_data = user_doc.to_dict()

            # Handle location, checking if it's None or GeoPoint
            location = user_data.get("location", None)
            if location is None:
                location = {"latitude": None, "longitude": None}  # Default if location is None

            # If location is a GeoPoint, convert it to a dictionary
            location = geo_point_to_dict(location)

            return jsonify({
                "bio": user_data.get("bio", ""),
                "university": user_data.get("school", ""),
                "field": user_data.get("field", ""),
                "level": user_data.get("level", ""),
                "location": location,  # Handle null or GeoPoint
                "name": user_data.get("username", ""),
                "dof": user_data.get("dateOfBirth", ""),
                "gender": user_data.get("gender", "")
            }), 200
        else:
            return jsonify({"error": "User not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route("/fetch_images", methods=["GET"])
def fetch_images():
    try:
        user_id = request.args.get("userID")

        if not user_id:
            return jsonify({"error": "userID is required"}), 400

        shots_ref = db.collection("userImages").document(user_id).collection("shots")
        shots_docs = shots_ref.stream()

        images = [doc.to_dict().get("imagePath") for doc in shots_docs if "imagePath" in doc.to_dict()]

        return jsonify({"images": images}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Delete Image
@app.route("/delete_image", methods=["POST"])
def delete_image():
    try:
        data = request.json
        user_id = data.get("userID")
        image_path = data.get("imagePath")

        if not user_id or not image_path:
            return jsonify({"error": "userID and imagePath are required"}), 400

        shots_ref = db.collection("userImages").document(user_id).collection("shots")
        query = shots_ref.where("imagePath", "==", image_path).stream()

        for doc in query:
            doc.reference.delete()
            return jsonify({"message": "Image deleted successfully"}), 200

        return jsonify({"error": "Image not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/save_profile_pic", methods=["POST"])
def save_profile_pic():
    try:
        data = request.json
        user_id = data.get("userID")
        image_path = data.get("imagePath")

        if not user_id or not image_path:
            return jsonify({"error": "userID and imagePath are required"}), 400

        user_ref = db.collection("users").document(user_id)
        user_ref.update({"profilePic": image_path})

        print(f"Image saved successfully for userID: {user_id}")
        return jsonify({"message": "Image saved successfully"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/delete_profile_pic", methods=["POST"])
def delete_profile_pic():
    try:
        data = request.json
        user_id = data.get("userID")

        if not user_id:
            return jsonify({"error": "userID is required"}), 400

        user_ref = db.collection("users").document(user_id)

        # Remove the profilePic field
        user_ref.update({"profilePic": firestore.DELETE_FIELD})
        print(f"Image removed successfully for userID: {user_id}")

        # Fetch the user's current 'complete' value
        user_doc = user_ref.get()
        if not user_doc.exists:
            return jsonify({"error": "User does not exist"}), 404

        user_data = user_doc.to_dict()
        current_value = user_data.get("complete", 0)
        updated_value = max(0, current_value - 10)  # Ensure it doesn't go below 0

        if current_value > 0:
            user_ref.update({"complete": updated_value})
            print(f"Decremented 'complete' field by 10 for userID: {user_id}")
        else:
            print(f"Cannot decrement. 'complete' field already at 0.")

        return jsonify({"message": "Profile picture removed, 'complete' field updated"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Set up logging configuration
logging.basicConfig(level=logging.INFO)

# Function to convert GeoPoint to dict
def geo_point_to_dict(geo_point):
    return {
        "latitude": geo_point.latitude,
        "longitude": geo_point.longitude
    }

@app.route("/get_user_profile", methods=["POST"])
def get_user_profile():
    try:
        data = request.json
        user_id = data.get("userID")

        if not user_id:
            return jsonify({"error": "userID is required"}), 400

        logging.info(f"📡 Fetching user profile for userID: {user_id}")

        # Use Firestore query with timeout
        user_ref = db.collection("users").document(user_id)
        user_doc = user_ref.get()  # Timeout after 5 seconds

        if not user_doc.exists:
            logging.warning(f"❌ User {user_id} does not exist")
            return jsonify({"error": "User profile does not exist"}), 404

        user_data = user_doc.to_dict()
        logging.info(f"✅ User data retrieved: {user_data}")

        # Handle GeoPoint for location
        location = user_data.get("location", "")
        if isinstance(location, firestore.GeoPoint):
            location = geo_point_to_dict(location)

        # Ensure fields exist before accessing
        response_data = {
            "username": user_data.get("username", ""),
            "fullName": user_data.get("fullName", ""),
            "email": user_data.get("email", ""),
            "profilePic": user_data.get("profilePic", ""),
            "interests": user_data.get("interests", []),
            "values": user_data.get("values", []),
            "spokenLanguages": user_data.get("spokenLanguages", []),
            "studyGoals": user_data.get("studyGoals", []),
            "location": location,  # Now GeoPoint is a dict with latitude and longitude
            "field": user_data.get("field", ""),
            "speciality": user_data.get("speciality", ""),
            "level": user_data.get("level", ""),
            "friends": user_data.get("friends", []),  # Handle missing field
        }

        return jsonify(response_data), 200

    except Exception as e:
        logging.error(f"🔥 Error fetching user profile: {e}", exc_info=True)
        return jsonify({"error": "Internal Server Error"}), 500
@app.route("/save_image", methods=["POST"])
def save_image():
    try:
        data = request.json
        user_id = data["userID"]
        image_path = data["imagePath"]

        # Reference to the user's shots collection
        shots_ref = db.collection("userImages").document(user_id).collection("shots")
        shots_docs = shots_ref.stream()

        # Count current images
        image_count = sum(1 for _ in shots_docs)
        if image_count >= 4:
            return jsonify({"error": "User already has 4 shots. Cannot add more."}), 400

        # Add new image path
        shots_ref.add({"imagePath": image_path})
        return jsonify({"message": "Image saved successfully", "userID": user_id}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Get user location
@app.route("/get_location/<user_id>", methods=["GET"])
def get_location(user_id):
    try:
        user_ref = db.collection("users").document(user_id)
        doc = user_ref.get()
        if doc.exists:
            return jsonify({"location": doc.to_dict().get("location", "Unknown")}), 200
        return jsonify({"error": "User not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Initialize geolocator (to convert location names to coordinates)
geolocator = Nominatim(user_agent="myApp")

@app.route("/update_location", methods=["POST"])
def update_location():
    try:
        data = request.json
        user_id = data["userID"]
        location = data["location"].strip()  # Get user input location
        
        user_ref = db.collection("users").document(user_id)
        address = location  # Default to user-entered text
        geo_point = None  # Default to None (if no valid coordinates are found)

        # Check if the location is in lat, lon format (coordinates)
        if "," in location and location.replace(" ", "").replace(".", "").replace(",", "").isdigit():
            try:
                lat, lon = location.split(", ")
                lat = float(lat)
                lon = float(lon)
                geo_point = firestore.GeoPoint(lat, lon)  # Create a GeoPoint for Firestore
                address = geolocator.reverse((lat, lon), exactly_one=True).address  # Get the address from coordinates
            except Exception as geo_error:
                print(f"Geocoding failed: {geo_error}")
        
        # If the location is not in lat, lon format, use geocoding to get the coordinates
        elif geo_point is None:
            location_obj = geolocator.geocode(location)
            if location_obj:
                lat, lon = location_obj.latitude, location_obj.longitude
                geo_point = firestore.GeoPoint(lat, lon)  # Create a GeoPoint for Firestore
                address = location_obj.address  # Get the address from geocoding result
            else:
                return jsonify({"message": "Could not find coordinates for the location"}), 400

        # Update the Firestore document with the location and GeoPoint
        user_ref.update({
            "location": geo_point,  # Store the GeoPoint object
            "address": address,  # Store the address or location name
        })

        return jsonify({"message": "Location updated successfully", "address": address, "geoPoint": geo_point.to_dict()}), 200

    except Exception as e:
        print(f"Error updating location: {e}")
        return jsonify({"message": "Failed to update location"}), 500
# Update user languages
@app.route("/update_languages", methods=["POST"])
def update_languages():
    try:
        data = request.json
        user_id = data["userID"]
        languages = data["languagesSpoken"]

        user_ref = db.collection("users").document(user_id)
        user_ref.update({"languagesSpoken": languages})

        return jsonify({"message": "Languages updated successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500




@app.route('/fetch_interests2', methods=['GET'])
def get_interests_v2():
    try:
        doc = db.collection('interests').document('interest').get()
        if doc.exists:
            interests = doc.to_dict().get('interest2', [])
            return jsonify({"interests": interests}), 200
        else:
            return jsonify({"error": "Document not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/update_interests2', methods=['POST'])
def update_interests2():
    try:
        data = request.json
        user_id = data.get('userID')
        selected_interests = data.get('values', [])

        if not user_id:
            return jsonify({"error": "User ID is required"}), 400

        db.collection('users').document(user_id).update({
            'values': selected_interests
        })
        return jsonify({"message": "Interests updated successfully"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500



@app.route('/update_interests', methods=['POST'])
def update_interests():
    try:
        data = request.get_json()
        user_id = data.get('userID')
        interests = data.get('interests', [])

        if not user_id or not isinstance(interests, list):
            return jsonify({"error": "Invalid input"}), 400

        user_doc_ref = db.collection('users').document(user_id)
        user_doc_ref.update({'interests': interests})

        return jsonify({"message": "Interests updated successfully"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500



@app.route('/fetch_interests', methods=['GET'])
def fetch_interests():
    try:
        doc_ref = db.collection('interests').document('interest')
        doc = doc_ref.get()

        if doc.exists:
            interests = doc.to_dict().get('interest1', [])  # Fetch 'interest1' array
            return jsonify({"interests": interests}), 200
        else:
            return jsonify({"error": "Document not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
@app.route('/load_student_profile', methods=['POST'])
def load_student_profile():
    try:
        # Parse userID from the request data
        data = request.get_json()
        user_id = data.get('userID', '').strip()

        if not user_id:
            return jsonify({'error': 'UserID is required'}), 400

        # Fetch the profile from Firestore using userID
        user_doc_ref = db.collection('users').document(user_id)
        doc_snapshot = user_doc_ref.get()

        if not doc_snapshot.exists:
            return jsonify({'error': 'User not found in Firestore'}), 404

        # Extract the student profile
        student_profile = doc_snapshot.to_dict()

        # Extract school name from email
        school = extract_school_name(student_profile.get('email', ''))

        # Include the school in the response
        student_profile['school'] = school

        return jsonify({'studentProfile': student_profile, 'school': school}), 200

    except Exception as e:
        print(f"Error loading student profile: {str(e)}")
        return jsonify({'error': f'Failed to load student profile: {str(e)}'}), 500


def extract_school_name(email):
    if not email or '@' not in email:
        return ''
    parts = email.split('@')
    domain = parts[1]
    domain_parts = domain.split('.')
    if domain_parts:
        return domain_parts[0]
    return ''  # Return empty string for invalid email


@app.route('/update_level', methods=['POST'])
def update_level():
    try:
        # Parse the request data
        data = request.get_json()
        user_id = data.get('userID', '').strip()
        level = data.get('level', '').strip()

        # Validate input
        if not user_id or not level:
            return jsonify({'error': 'userID and level are required'}), 400

        # Reference the user document
        user_doc_ref = db.collection('users').document(user_id)

        # Update the `level` field
        user_doc_ref.update({'level': level})

        return jsonify({'message': 'Level updated successfully', 'updatedLevel': level}), 200

    except Exception as e:
        print(f"Error updating level: {str(e)}")
        return jsonify({'error': f'Failed to update level: {str(e)}'}), 500
    
    
@app.route('/update_field', methods=['POST'])
def update_field():
    try:
        # Parse request data
        data = request.get_json()
        user_id = data.get('userID', '').strip()
        selected_field = data.get('field', '').strip()

        # Validate required fields
        if not user_id or not selected_field:
            return jsonify({'error': 'Missing required fields'}), 400

        # Update the user's field in Firestore
        users_ref = db.collection('users').document(user_id)
        users_ref.update({'field': selected_field})

        # Fetch data based on the updated field (if needed)
        fetched_data = db.collection('some_collection').where('field', '==', selected_field).stream()
        fetched_results = [doc.to_dict() for doc in fetched_data]

        return jsonify({
            'message': 'Field updated successfully',
            'updatedField': selected_field,
            'fetchedResults': fetched_results
        }), 200

    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': f'Failed to update field: {str(e)}'}), 500
    
@app.route('/update_profile', methods=['POST'])
def update_profile():
    try:
       # Parse request data
        data = request.get_json()
        print(f"Received data: {data}")  # Log the request data

        username = data.get('username', '').strip()
        phone_number = data.get('phoneNumber', '').strip()
        password = data.get('password', '').strip()
        selected_gender = data.get('gender', '').strip()
        year = data.get('year', '')
        month = data.get('month', '')
        day = data.get('day', '')
        user_id = data.get('userID', '').strip()

        # Validate required fields
        if not username or not phone_number or not password or not user_id:
            return jsonify({'error': 'Missing required fields'}), 400
        # Check if the username already exists
        users_ref = db.collection('users')
        query = users_ref.where('username', '==', username).stream()
        existing_user = list(query)

        # Check if username is already in use by another user
        if existing_user and existing_user[0].id != user_id:
            return jsonify({'error': 'Username already exists, try a different one.'}), 400

        # Hash the password
        def hash_password(password):
            hashed = hashlib.sha256(password.encode('utf-8')).hexdigest()
            return hashed

        # Prepare the updated profile data
        # Format the date as dd-mm-yyyy
        formatted_date_of_birth = f"{day.zfill(2)}-{month.zfill(2)}-{year}"

        updated_profile = {
            'username': username,
            'phoneNumber': phone_number,
            'password': hash_password(password),
            'gender': selected_gender,
            'dateOfBirth': formatted_date_of_birth,  # Store as string in dd-mm-yyyy format
            'complete':'50',
        }

        # Update the user's profile
        user_doc_ref = users_ref.document(user_id)
        user_doc_ref.update(updated_profile)

        return jsonify({'message': 'Profile updated successfully'}), 200

    except Exception as e:
        print(f"Error updating profile: {str(e)}")
        return jsonify({'error': f'Failed to update profile: {str(e)}'}), 500

    
def extract_full_name_from_email(email):
    """
    Extracts the full name from an email address.
    """
    name_part = email.split('@')[0]
    full_name = ' '.join(name_part.split('.'))
    return full_name
@app.route('/add_user', methods=['POST'])
def add_user():
    try:
        
        data = request.get_json()
        email = data.get('email', '').strip()
        school = data.get('school', '').strip()
        if not email:
            return jsonify({'error': 'Email is required'}), 400

        users_ref = db.collection('users')
        query = users_ref.where('email', '==', email).stream()
        existing_user = list(query)

        if existing_user:
            return jsonify({'error': 'Email is already registered'}), 400

     
        full_name = extract_full_name_from_email(email)

     
        new_doc_ref = users_ref.document()
        user_id = new_doc_ref.id  

   
        new_user = {
            'email': email,
            'school': school,
            'fullName': full_name,
            'active': True,
            'bio': "",
            'school': "",
            'profilePic': "",
            # "complete": 0
        }

        new_doc_ref.set(new_user)

        print(f"New User ID: {user_id}")
        return jsonify({'message': 'User added successfully', 'userId': user_id}), 201

    except Exception as e:
        print(f"Error adding user to Firestore: {str(e)}")
        return jsonify({'error': f'Failed to create user: {str(e)}'}), 500


def send_email(to_email, code):
    smtp_server = "smtp.gmail.com"
    smtp_port = 587
    sender_email = os.getenv("SENDER_EMAIL")  # Use environment variable for sender email
    sender_password = os.getenv("SENDER_PASSWORD")  # Use environment variable for password

    if not sender_email or not sender_password:
        raise ValueError("Email credentials are not set in environment variables")

    # Email content
    subject = "Your Verification Code"
    body = f"Your verification code is: {code}"

    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = to_email
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))

    try:
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, sender_password)
        server.send_message(msg)
        server.quit()

        print(f"Verification code {code} successfully sent to {to_email}.")
    except Exception as e:
        print(f"Failed to send email: {e}")
        raise
# Route to send a verification code
@app.route('/send_code', methods=['POST'])
def send_code():
    data = request.json
    email = data.get('email')

    if not email or not re.match(r"[^@]+@[^@]+\.[^@]+", email):
        return jsonify({'error': 'Invalid email format'}), 400

    # Remove expired codes from the database
    expired_emails = [email for email, data in email_verification_db.items()
                      if data['expires_at'] < datetime.datetime.utcnow()]
    for email in expired_emails:
        del email_verification_db[email]

    # Check if the email already exists and the code hasn't expired
    if email in email_verification_db:
        stored_data = email_verification_db[email]
        if datetime.datetime.utcnow() <= stored_data['expires_at']:
            return jsonify({'message': 'Code already sent and is still valid'}), 200

    # Generate a new code
    code = str(random.randint(10000, 99999))
    expires_at = datetime.datetime.utcnow() + datetime.timedelta(minutes=10)

    # Store the code and expiration time in the database
    email_verification_db[email] = {'code': code, 'expires_at': expires_at}

    try:
        send_email(email, code)
        return jsonify({'message': 'Code sent successfully'}), 200
    except Exception as e:
        return jsonify({'error': f'Failed to send email: {str(e)}'}), 500

# Route to verify the code
@app.route('/verify_code', methods=['POST'])
def verify_code():
    data = request.json
    email = data.get('email')
    entered_code = data.get('code')

    if not email or not entered_code:
        return jsonify({'error': 'Email and code are required'}), 400

    if email in email_verification_db:
        stored_data = email_verification_db[email]
        if stored_data['code'] == entered_code:
            if datetime.datetime.utcnow() <= stored_data['expires_at']:
                return jsonify({'success': True}), 200
            else:
                return jsonify({'success': False, 'error': 'Code expired'}), 400
        else:
            return jsonify({'success': False, 'error': 'Invalid code'}), 400
    else:
        return jsonify({'success': False, 'error': 'Email not found'}), 404

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)
