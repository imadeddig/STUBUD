import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _databaseName = "stubud.db";
  static const _databaseVersion = 1;

  // Singleton instance
  static Database? _database;

  // Method to initialize and retrieve the database
  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    // Initialize the database
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE StudentProfile (
    userID INTEGER PRIMARY KEY AUTOINCREMENT,  -- Automatically increments userID
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    gender TEXT CHECK(gender IN ('Male', 'Female', 'Other')),
    dateOfBirth DATE,
    school VARCHAR(255),
    wilaya VARCHAR(255),
    field VARCHAR(255),
    speciality VARCHAR(255),
    level VARCHAR(50),
    location VARCHAR(255),
    phoneNumber VARCHAR(15),
    bio TEXT,
    profilePicture VARCHAR(2083) 
);
        ''');
        await db.execute('''
        CREATE TABLE UserImages (
    imageID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key for this table
    userID INT NOT NULL,                    -- Foreign Key referencing StudentProfile
    imageUrl VARCHAR(2083) NOT NULL,        -- Image URL (maximum URL length)
    
    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                   -- Delete images if the user is deleted
);
        ''');
        await db.execute('''
        CREATE TABLE UserInterests (
    interestID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key for each interest
    userID INT NOT NULL,                      -- Foreign Key referencing StudentProfile
    interest VARCHAR(255) NOT NULL,           -- Name of the interest

    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                     -- Cascade delete with user
)
        ''');
        await db.execute('''
        CREATE TABLE UserValues (
    valueID INT AUTO_INCREMENT PRIMARY KEY,   -- Primary Key for each value
    userID INT NOT NULL,                      -- Foreign Key referencing StudentProfile
    valueName VARCHAR(255) NOT NULL,          -- Name of the value

    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                     -- Cascade delete with user
)
        ''');
        await db.execute('''
          CREATE TABLE UserLanguages (
    languageID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key for each language
    userID INT NOT NULL,                        -- Foreign Key referencing StudentProfile
    languageName VARCHAR(255) NOT NULL,         -- Name of the language

    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                       -- Cascade delete with user
)
        ''');
        // Safety system table
        await db.execute('''
                        CREATE TABLE UserPreferredStudyTimes (
    studyTimeID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key for each study time
    userID INT NOT NULL,                         -- Foreign Key referencing StudentProfile
    studyTimeCategory TEXT NOT NULL CHECK(studyTimeCategory IN ('Morning', 'Afternoon', 'Evening', 'Night')),  -- Enforce valid values

    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                        -- Cascade delete with user
)
                      ''');

        // Lights table
        await db.execute('''
                      CREATE TABLE UserPreferredStudyMethods (
    studyMethodID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key for each study method
    userID INT NOT NULL,                          -- Foreign Key referencing StudentProfile
    studyMethod VARCHAR(255) NOT NULL,            -- Study method description

    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                         -- Cascade delete with user
)
                      ''');

        // oil table
        await db.execute('''
                        CREATE TABLE UserPurposesAndGoals (
    purposeID INT AUTO_INCREMENT PRIMARY KEY,   -- Primary Key for each purpose/goal
    userID INT NOT NULL,                        -- Foreign Key referencing StudentProfile
    purposeDescription TEXT NOT NULL,           -- Description of the purpose/goal

    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                       -- Cascade delete with user
)
                      ''');

        // Alignment  table
        await db.execute('''
                      CREATE TABLE UserCommunicationMethods (
    communicationID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key for each communication method
    userID INT NOT NULL,                             -- Foreign Key referencing StudentProfile
    communicationMethod VARCHAR(255) NOT NULL,       -- Name of the communication method

    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                            -- Cascade delete with user
)
                      ''');

        // TIRE  table
        await db.execute('''
                        CREATE TABLE UserAcademicStrengths (
    strengthID INT AUTO_INCREMENT PRIMARY KEY,    -- Primary Key for each strength
    userID INT NOT NULL,                          -- Foreign Key referencing StudentProfile
    academicStrength VARCHAR(255) NOT NULL,       -- Name of the academic strength

    FOREIGN KEY (userID) REFERENCES StudentProfile(userID)
        ON DELETE CASCADE                         -- Cascade delete with user
);

                      ''');

                      await db.execute('''
CREATE TABLE ChatSessions (
    chatID INTEGER PRIMARY KEY AUTOINCREMENT,  -- Primary key for each chat session
    user1ID INTEGER NOT NULL,                 -- Foreign key: User 1 (the current user)
    user2ID INTEGER NOT NULL,                 -- Foreign key: User 2 (the other participant)
    lastMessage TEXT,                         -- Stores the most recent message exchanged
    lastMessageTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp of the last message
    FOREIGN KEY (user1ID) REFERENCES StudentProfile(userID) ON DELETE CASCADE,
    FOREIGN KEY (user2ID) REFERENCES StudentProfile(userID) ON DELETE CASCADE
);
''');

        await db.execute('''
CREATE TABLE Messages (
    messageID INTEGER PRIMARY KEY AUTOINCREMENT, -- Unique ID for each message
    chatID INTEGER NOT NULL,                     -- Foreign key referencing ChatSessions
    senderID INTEGER NOT NULL,                   -- Foreign key: User who sent the message
    receiverID INTEGER NOT NULL,                 -- Foreign key: User who received the message
    message TEXT NOT NULL,                       -- The message content
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Time the message was sent
    FOREIGN KEY (chatID) REFERENCES ChatSessions(chatID) ON DELETE CASCADE,
    FOREIGN KEY (senderID) REFERENCES StudentProfile(userID) ON DELETE CASCADE,
    FOREIGN KEY (receiverID) REFERENCES StudentProfile(userID) ON DELETE CASCADE
);
''');
      },
      version: _databaseVersion,
      onUpgrade: (db, oldVersion, newVersion) {
        // Handle database upgrades if needed
      },
    );

    return _database!;
  }
}


