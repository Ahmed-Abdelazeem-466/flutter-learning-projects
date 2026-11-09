import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_chat/models/message.dart';
import 'package:file_selector/file_selector.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ChatService extends ChangeNotifier {
  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get all users stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // get all users stream except blocked users
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = _auth.currentUser;
    return _firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .snapshots()
        .asyncMap((snapshot) async {
          final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

          final userSnapshot = await _firestore.collection("Users").get();

          return userSnapshot.docs
              .where(
                (doc) =>
                    doc.id != currentUser.uid &&
                    !blockedUserIds.contains(doc.id),
              )
              .map((doc) {
                final data = doc.data();
                data['uid'] = doc.id; // This is critical
                return data;
              })
              .toList();
        });
  }

  // upload the file to storage
  Future<String> uploadFileToStorage(File file, String folderName) async {
    final ref = FirebaseStorage.instance.ref().child(
      '$folderName/${DateTime.now().millisecondsSinceEpoch}',
    );

    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String?> uploadFileToCloudinary(File file, String folderName) async {
    const cloudName = 'YOUR_CLOUDINARY_CLOUD_NAME'; // Cloudinary Cloud Name
    const uploadPreset = 'YOUR_UNSIGNED_UPLOAD_PRESET'; // Upload Preset

    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload');

    final request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = uploadPreset
          ..fields['folder'] = folderName
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              file.path,
              contentType: MediaType('application', 'octet-stream'),
            ),
          );

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStream = await response.stream.bytesToString();
      final data = jsonDecode(resStream);
      return data['secure_url']; // 🔥 This is the link you will save in your database
    } else {
      print('Upload failed: ${response.statusCode}');
      return null;
    }
  }

  // pick images from gallery
  Future<String?> pickImageAndUploadToCloudinary() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final downloadUrl = await uploadFileToCloudinary(
        file,
        'chat_uploads',
      ); // 👈 call the function

      return downloadUrl; // this is the link to store in Firestore
    }
    return null;
  }

  // pick images from camera
  Future<String?> pickImageFromCameraAndUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final downloadUrl = await uploadFileToStorage(file, 'images');
      return downloadUrl;
    }
    return null;
  }

  // pick document
  Future<String?> pickDocumentUsingFileSelector() async {
    final XFile? file = await openFile(
      acceptedTypeGroups: [
        XTypeGroup(
          label: 'documents',
          extensions: ['pdf', 'doc', 'docx', 'zip'],
        ),
      ],
    );

    if (file != null) {
      final File convertedFile = File(file.path);
      final downloadUrl = await uploadFileToStorage(convertedFile, 'documents');
      return downloadUrl;
    }
    return null;
  }

  // send messages
  Future<void> sendMessage(
    String receiverID,
    message, {
    required bool isImage,
  }) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
      isImage: isImage,
    );

    // construct chat room ID for the two users (sorted to ensure uniquenes)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort the ids (this ensure the chatroomID is the same for any 2 people)
    String chatRoomID = ids.join("_");

    // add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // report user
  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = _auth.currentUser;
    final report = {
      "reportedBy": currentUser!.uid,
      "messageId": messageId,
      "messageOwnerId": userId,
      "timestamp": FieldValue.serverTimestamp(),
    };

    await _firestore.collection("Reports").add(report);
  }

  // block user
  Future<void> blockUser(String userId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .doc(userId)
        .set({});

    // Force listeners to refresh
    notifyListeners();
  }

  // unblock user
  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .doc(blockedUserId)
        .delete();
  }

  // delete message
  Future<void> deleteMessage(String messageId, String otherUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join("_");

    await FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .doc(messageId)
        .delete();
  }

  // get blocked user stream
  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId) {
    return _firestore
        .collection("Users")
        .doc(userId)
        .collection("BlockedUsers")
        .snapshots()
        .asyncMap((snapshot) async {
          // get list of blocked user ids
          final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

          List<Map<String, dynamic>> blockedUsersList = [];

          // Fetch each user individually to handle errors per user
          for (String id in blockedUserIds) {
            try {
              final docSnapshot =
                  await _firestore.collection("Users").doc(id).get();

              // Check if document exists and has data
              if (docSnapshot.exists && docSnapshot.data() != null) {
                blockedUsersList.add(docSnapshot.data()!);
              }
            } catch (e) {
              // Log error but continue with other users
              print("Error fetching blocked user $id: $e");
            }
          }
          return blockedUsersList;
        });
  }
}
