# Firebase Setup for Kids Version

## Overview
This document provides instructions for setting up Firebase for the Daily Muslim Routine Kids app.

## Prerequisites
- Firebase CLI installed (`npm install -g firebase-tools`)
- FlutterFire CLI installed (`dart pub global activate flutterfire_cli`)
- Flutter project initialized

## Steps to Setup Firebase

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: `daily-muslim-routine-kids`
4. Enable Google Analytics (optional)
5. Create project

### 2. Add Android App
1. In Firebase Console, click "Add app" → Android
2. Enter package name: `com.example.islamic_daily_routine_kids`
3. Download `google-services.json`
4. Place it in `android/app/` directory

### 3. Add iOS App
1. In Firebase Console, click "Add app" → iOS
2. Enter bundle ID: `com.example.islamicDailyRoutineKids`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

### 4. Configure Firebase Services
Enable the following services in Firebase Console:

#### Authentication
1. Go to Authentication → Sign-in method
2. Enable Email/Password authentication
3. Configure any additional providers if needed

#### Firestore Database
1. Go to Firestore Database
2. Create database in production mode
3. Choose location (preferably close to your users)

#### Storage (Optional)
1. Go to Storage
2. Get started with default rules
3. Choose location

### 5. Generate Firebase Configuration
Run the following command in the project root:

```bash
flutterfire configure --project=daily-muslim-routine-kids
```

This will:
- Generate `lib/firebase_options.dart`
- Update Android and iOS configurations
- Set up the project for Firebase

### 6. Update Firestore Rules
Replace the default Firestore rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Users can read/write their own daily progress
    match /users/{userId}/daily_progress/{progressId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Users can read/write their own Quran memorization
    match /users/{userId}/quran_memorization/{memorizationId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 7. Test Firebase Connection
Run the app and check if Firebase initializes correctly:

```bash
flutter run
```

Look for Firebase initialization messages in the console.

## Firebase Features Used in Kids App

### Authentication
- Email/Password signup and login
- User profile management
- Password reset functionality

### Firestore Database
- User profiles storage
- Daily progress tracking
- Quran memorization progress
- Prayer time preferences

### Cloud Storage (Optional)
- Profile pictures
- Audio files for prayers/azkar

## Security Considerations

1. **Data Privacy**: All user data is private and only accessible by the authenticated user
2. **Child Safety**: No personal information is shared or made public
3. **Data Retention**: Users can delete their accounts and all associated data
4. **Offline Support**: App works offline and syncs when connection is restored

## Troubleshooting

### Common Issues

1. **Firebase not initializing**
   - Check if `google-services.json` and `GoogleService-Info.plist` are in correct locations
   - Verify package name/bundle ID matches Firebase project

2. **Authentication errors**
   - Ensure Email/Password is enabled in Firebase Console
   - Check Firestore rules allow authenticated users

3. **Build errors**
   - Run `flutter clean` and `flutter pub get`
   - Check Firebase dependencies in `pubspec.yaml`

### Support
For Firebase-specific issues, refer to:
- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)

## Next Steps
After Firebase setup is complete:
1. Test user registration and login
2. Verify data sync between devices
3. Test offline functionality
4. Configure push notifications (optional)
