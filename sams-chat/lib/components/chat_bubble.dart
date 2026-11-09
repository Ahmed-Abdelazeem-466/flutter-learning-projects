import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sams_chat/services/chat/chat_service.dart';
import 'package:sams_chat/themes/theme_provider.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;
  final Timestamp timestamp;
  final String receiverID; // 👈 Add this

  const ChatBubble({
    super.key,
    required this.receiverID,
    required this.isCurrentUser,
    required this.message,
    required this.messageId,
    required this.userId,
    required this.timestamp,
  });

  // show options
  void _showOptions(BuildContext context, String userId) {
    final isMyMessage = isCurrentUser;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              // if current user he will show delete
              if (isMyMessage)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Delete Message"),
                  onTap: () async {
                    Navigator.pop(context);
                    await ChatService().deleteMessage(messageId, receiverID);
                  },
                )
              else ...[
                // report message button
                ListTile(
                  leading: const Icon(Icons.flag),
                  title: const Text("Report Message"),
                  onTap: () {
                    Navigator.pop(context);
                    _reportMessage(context, messageId, userId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Message Reported"),
                        backgroundColor: Colors.yellow,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],

              // cancel button
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text("Cancel"),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // report message
  void _reportMessage(BuildContext context, String messageId, userId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Report Message"),
            content: const Text(
              "Are you sure you want to report this message?",
            ),
            actions: [
              // cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),

              // report button
              TextButton(
                onPressed: () {
                  ChatService().reportUser(messageId, userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Message Reported")),
                  );
                },
                child: const Text("Report"),
              ),
            ],
          ),
    );
  }

  // block user
  void _blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Block User"),
            content: const Text("Are you sure you want to block this user?"),
            actions: [
              // cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),

              // block button
              TextButton(
                onPressed: () async {
                  // perform block
                  await ChatService().blockUser(userId);

                  Navigator.pop(context); // close alert
                  Navigator.pop(context); // go back
                  // let user know of result
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("The User has been Blocked!!"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text("Block"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // light vs dark mode for correct bubble colors
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onLongPress: () {
        _showOptions(context, userId);
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              isCurrentUser
                  ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
                  : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 5),
        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // the text you wrote
            Text(
              message,
              style: TextStyle(
                color:
                    isCurrentUser
                        ? Colors.white
                        : (isDarkMode ? Colors.white : Colors.black),
              ),
            ),
            const SizedBox(height: 0.5),
            // timestamp
            Text(
              DateFormat('hh:mm a').format(timestamp.toDate()),
              style: TextStyle(
                fontSize: 12,
                color:
                    isCurrentUser
                        ? Colors.white70
                        : (isDarkMode ? Colors.white60 : Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
