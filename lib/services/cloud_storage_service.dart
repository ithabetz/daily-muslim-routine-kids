import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import '../models/daily_progress.dart';
import '../models/quran_memorization.dart';

class CloudStorageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Helper method to convert date to document key
  String _dateToKey(DateTime date) {
    return '${date.year}_${date.month.toString().padLeft(2, '0')}_${date.day.toString().padLeft(2, '0')}';
  }

  // User Profile Methods
  Future<void> createUserProfile(UserProfile profile) async {
    try {
      await _firestore.collection('users').doc(profile.uid).set(profile.toJson());
    } catch (e) {
      throw 'Failed to create user profile: $e';
    }
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      throw 'Failed to update user profile: $e';
    }
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserProfile.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw 'Failed to get user profile: $e';
    }
  }

  Stream<UserProfile?> userProfileStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists ? UserProfile.fromJson(doc.data()!) : null);
  }

  // Daily Progress Methods
  Future<void> saveDailyProgress(String uid, DailyProgress progress) async {
    try {
      final dateKey = _dateToKey(progress.date);
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('daily_progress')
          .doc(dateKey)
          .set(progress.toJson());
    } catch (e) {
      throw 'Failed to save daily progress: $e';
    }
  }

  Future<DailyProgress?> getDailyProgress(String uid, String dateKey) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .collection('daily_progress')
          .doc(dateKey)
          .get();
      
      if (doc.exists) {
        return DailyProgress.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw 'Failed to get daily progress: $e';
    }
  }

  Stream<List<DailyProgress>> getDailyProgressStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('daily_progress')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DailyProgress.fromJson(doc.data()))
            .toList());
  }

  // Quran Memorization Methods
  Future<void> saveQuranMemorization(String uid, QuranMemorization memorization) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('quran_memorization')
          .doc('current')
          .set(memorization.toJson());
    } catch (e) {
      throw 'Failed to save Quran memorization: $e';
    }
  }

  Future<QuranMemorization?> getQuranMemorization(String uid) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .collection('quran_memorization')
          .doc('current')
          .get();
      
      if (doc.exists) {
        return QuranMemorization.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw 'Failed to get Quran memorization: $e';
    }
  }

  Stream<QuranMemorization?> getQuranMemorizationStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('quran_memorization')
        .doc('current')
        .snapshots()
        .map((doc) => doc.exists ? QuranMemorization.fromJson(doc.data()!) : null);
  }

  // Data Management Methods
  Future<void> deleteUserData(String uid) async {
    try {
      // Delete user profile
      await _firestore.collection('users').doc(uid).delete();
      
      // Delete daily progress collection
      final dailyProgressSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('daily_progress')
          .get();
      
      for (final doc in dailyProgressSnapshot.docs) {
        await doc.reference.delete();
      }
      
      // Delete Quran memorization collection
      final quranMemorizationSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('quran_memorization')
          .get();
      
      for (final doc in quranMemorizationSnapshot.docs) {
        await doc.reference.delete();
      }
      
    } catch (e) {
      throw 'Failed to delete user data: $e';
    }
  }

  // Backup and Restore Methods
  Future<Map<String, dynamic>> backupUserData(String uid) async {
    try {
      final Map<String, dynamic> backup = {};
      
      // Backup user profile
      final profile = await getUserProfile(uid);
      if (profile != null) {
        backup['profile'] = profile.toJson();
      }
      
      // Backup daily progress
      final dailyProgressSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('daily_progress')
          .get();
      
      backup['daily_progress'] = dailyProgressSnapshot.docs
          .map((doc) => {'id': doc.id, 'data': doc.data()})
          .toList();
      
      // Backup Quran memorization
      final quranMemorization = await getQuranMemorization(uid);
      if (quranMemorization != null) {
        backup['quran_memorization'] = quranMemorization.toJson();
      }
      
      return backup;
    } catch (e) {
      throw 'Failed to backup user data: $e';
    }
  }

  Future<void> restoreUserData(String uid, Map<String, dynamic> backup) async {
    try {
      // Restore user profile
      if (backup['profile'] != null) {
        await _firestore.collection('users').doc(uid).set(backup['profile']);
      }
      
      // Restore daily progress
      if (backup['daily_progress'] != null) {
        final dailyProgressList = backup['daily_progress'] as List;
        for (final item in dailyProgressList) {
          final id = item['id'] as String;
          final data = item['data'] as Map<String, dynamic>;
          await _firestore
              .collection('users')
              .doc(uid)
              .collection('daily_progress')
              .doc(id)
              .set(data);
        }
      }
      
      // Restore Quran memorization
      if (backup['quran_memorization'] != null) {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('quran_memorization')
            .doc('current')
            .set(backup['quran_memorization']);
      }
      
    } catch (e) {
      throw 'Failed to restore user data: $e';
    }
  }

  Future<void> syncQuranMemorizationToCloud(String userId, QuranMemorization memorization) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('memorization')
          .doc('current')
          .set(memorization.toJson());
    } catch (e) {
      throw Exception('Failed to sync Quran memorization: $e');
    }
  }
}