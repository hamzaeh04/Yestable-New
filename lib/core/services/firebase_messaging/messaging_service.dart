import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MessagingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// -----------------------------
  /// CREATE GROUP
  /// -----------------------------
  Future<String> createGroup({
    required String imagePath,
    required String name,
    required String createdBy,
    required bool enableGroup,
    required String eventId,
    required String adminId,
    required String invitationMsg,
    required String adminProfilePic,
  }) async {
    final groupRef = _firestore.collection('group').doc(eventId);

    await groupRef.set({
      "groupId": eventId,
      "GroupName": name,
      "EventId": eventId,
      "imagePath": imagePath,
      "createdBy": createdBy,
      "createdAt": FieldValue.serverTimestamp(),
      "adminName": [createdBy],
      "adminId": adminId,
      "adminProfilePic": adminProfilePic,
      "lastMessage": "",
      "lastMessageSenderName": "",
      "membersCount": 1,
      "lastMessageTime": FieldValue.serverTimestamp(),
      "disableGroup": enableGroup,
      "groupDescription": invitationMsg
    });
    /// 🔥 ADD ADMIN AS MEMBER
    await groupRef
        .collection("members")
        .doc(adminId)
        .set({

      "userId": adminId,
      "userName": createdBy,
      "memberProfile": adminProfilePic,

      "joinedAt": FieldValue.serverTimestamp(),

      "lastReadAt": FieldValue.serverTimestamp(),

      "isAdmin": true,
    });
    return groupRef.id;
  }

  /// -----------------------------
  /// JOIN GROUP
  /// -----------------------------
  Future<void> joinGroup({
    required String groupId,
    required String userName,
    required String userId,
    required String memberProfile
  }) async {
    final memberRef = _firestore
        .collection("group")
        .doc(groupId)
        .collection("members")
        .doc(userId);

    await memberRef.set({
      "userId": userId,
      "userName": userName,
      "memberProfile":memberProfile,
      /// ✔ keep join time only
      "joinedAt": FieldValue.serverTimestamp(),

      /// 🔥 NEW: track last read separately
      "lastReadAt": FieldValue.serverTimestamp(),
    });

    await _firestore.collection("group").doc(groupId).update({
      "membersCount": FieldValue.increment(1),
    });
  }

  /// -----------------------------
  /// SEND MESSAGE
  /// -----------------------------
  Future<void> sendMessage({
    required String groupId,
    required String userId,
    required String userName,
    required String message,
  }) async {
    final groupDoc = _firestore.collection("group").doc(groupId);

    final msgRef = groupDoc.collection("messages").doc();

    await msgRef.set({
      "messageId": msgRef.id,
      "senderId": userId,
      "senderName": userName,
      "message": message,
      "createdAt": FieldValue.serverTimestamp(),
    });

    await groupDoc.update({
      "lastMessage": message,
      "lastMessageSenderName": userName,
      "lastMessageTime": FieldValue.serverTimestamp(),
    });
  }

  /// -----------------------------
  /// GET UNREAD COUNT (FIXED)
  /// -----------------------------
  Stream<int> getUnreadCount({
    required String groupId,
    required String userId,
  }) {
    return _firestore
        .collection("group")
        .doc(groupId)
        .collection("members")
        .doc(userId)
        .snapshots()
        .asyncMap((memberSnap) async {
      if (!memberSnap.exists) return 0;

      final data = memberSnap.data();

      final Timestamp? lastReadAt =
      data?["lastReadAt"] as Timestamp?;

      if (lastReadAt == null) return 0;

      final result = await _firestore
          .collection("group")
          .doc(groupId)
          .collection("messages")
          .where("createdAt", isGreaterThan: lastReadAt)
          .count()
          .get();

      return result.count ?? 0;
    });
  }

  /// -----------------------------
  /// MARK AS READ (FIXED)
  /// -----------------------------
  Future<void> markAsRead({
    required String groupId,
    required String userId,
  }) async {
    await _firestore
        .collection("group")
        .doc(groupId)
        .collection("members")
        .doc(userId)
        .update({
      /// ✔ correct field (DO NOT overwrite joinedAt)
      "lastReadAt": FieldValue.serverTimestamp(),
    });
  }

  /// -----------------------------
  /// Exit Group (FIXED)
  /// -----------------------------
  ///
  Future<void> exitGroup({
    required String groupId,
    required String userId
  }) async{
    final memberRef = _firestore
        .collection("group")
        .doc(groupId)
        .collection("members")
        .doc(userId);

    await memberRef.delete();
    try {
      /// Decrease member count safely
      await _firestore.collection("group").doc(groupId).update({
        "membersCount": FieldValue.increment(-1),
      });
    } catch (e) {
      debugPrint("exitGroup membersCount update failed: $e");
    }
  }
/// -----------------------------
/// Delede Group (FIXED)
/// -----------------------------
///
  Future<void> deledeGroup({
    required String groupId,
  }) async{
    final groupRef = _firestore
        .collection("group")
        .doc(groupId);

    await groupRef.delete();
  }

}





