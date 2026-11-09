import 'package:flutter/material.dart';
import 'package:sams_chat/components/user_tile.dart';
import 'package:sams_chat/services/Auth/auth_service.dart';
import 'package:sams_chat/services/chat/chat_service.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  // chat & auth service
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  // show confirm unblock box
  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Unblock User"),
            content: const Text("Are you sure you want to unblock this user?"),
            actions: [
              // cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),

              // unblock button
              TextButton(
                onPressed: () {
                  chatService.unblockUser(userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("The User has been unblocked!!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text("Unblock"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get current user id
    String userId = authService.getCurrentUser()!.uid;

    // UI
    return Scaffold(
      appBar: AppBar(title: Text("Blocked Users"), centerTitle: true),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBlockedUsersStream(userId),
        builder: (context, snapshot) {
          // errors..
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading..."));
          }

          // loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final blockedUsers = snapshot.data ?? [];

          // no users
          if (blockedUsers.isEmpty) {
            return const Center(child: Text("No blocked users"));
          }

          // load complete
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17, bottom: 8),
                child: Text(
                  "Blocked Users (${blockedUsers.length})",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: blockedUsers.length,
                  itemBuilder: (context, index) {
                    final user = blockedUsers[index];
                    return UserTile(
                      onTap: () => _showUnblockBox(context, user["uid"]),
                      text: user["email"],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
