import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sams_chat/components/chat_bubble.dart';
import 'package:sams_chat/components/my_textfield.dart';
import 'package:sams_chat/services/Auth/auth_service.dart';
import 'package:sams_chat/services/chat/chat_service.dart';
import 'package:file_selector/file_selector.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // for textfield focus
  FocusNode myFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated
        // then scroll down
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });
    // wait a bit for listview to be built, then scroll to bottom
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // time label
  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) return "Today";
    if (messageDate == yesterday) return "Yesterday";
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  // scroll controller
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final imageUrl =
                      await _chatService.pickImageAndUploadToCloudinary();
                  print('Gallery picked URL: $imageUrl');
                  if (imageUrl != null) {
                    await _chatService.sendMessage(
                      widget.receiverID,
                      imageUrl,
                      isImage: true,
                    );
                    scrollDown();
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final imageUrl =
                      await _chatService.pickImageFromCameraAndUpload();
                  if (imageUrl != null) {
                    await _chatService.sendMessage(
                      widget.receiverID,
                      imageUrl,
                      isImage: true,
                    );
                    scrollDown();
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text('Document'),
                onTap: () async {
                  Navigator.pop(context);
                  final fileUrl =
                      await _chatService.pickDocumentUsingFileSelector();
                  print('Document picked URL: $fileUrl');
                  if (fileUrl != null) {
                    await _chatService.sendMessage(
                      widget.receiverID,
                      fileUrl,
                      isImage: false, // Because it's a document, not image
                    );
                    scrollDown();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
        isImage: false,
      );

      // clear text controller
      _messageController.clear();
    }
    scrollDown();
  }

  // show options
  void _showOptions(BuildContext context, String userId) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                // report message button
                ListTile(
                  leading: const Icon(Icons.flag),
                  title: const Text("Report User"),
                  onTap: () {
                    Navigator.pop(context);
                    _reportUser(context, userId);
                  },
                ),

                // block user button
                ListTile(
                  leading: const Icon(Icons.block),
                  title: const Text("Block User"),
                  onTap: () {
                    Navigator.pop(context);
                    _blockUser(context, userId);
                  },
                ),

                // cancel button
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Cancel"),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
    );
  }

  // report message
  void _reportUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Report User"),
            content: const Text("Are you sure you want to report this user?"),
            actions: [
              // cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),

              // report button
              TextButton(
                onPressed: () async {
                  await _chatService.reportUser("", userId);
                  Navigator.pop(context);

                  // let the user know the result
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("The User has been reported"),
                      backgroundColor: Colors.yellow,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
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
                  await _chatService.blockUser(userId);
                  Navigator.pop(context); // close alert
                  Navigator.pop(context); // go back

                  // let user know the result
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptions(context, widget.receiverID),
          ),
        ],
      ),

      body: Column(
        children: [
          // display allll messages
          Expanded(child: _buildMessageList()),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text("Error");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        final messages = snapshot.data!.docs;

        List<Widget> messageWidgets = [];
        String? lastDate;

        for (var doc in messages) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          DateTime timestamp = data["timestamp"].toDate();
          String dateLabel = _getDateLabel(timestamp);

          // Add date header if it's a new date
          if (lastDate != dateLabel) {
            messageWidgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    dateLabel,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
            lastDate = dateLabel;
          }

          // Add the actual message bubble
          bool isCurrentUser = data["senderID"] == senderID;
          messageWidgets.add(
            Container(
              alignment:
                  isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
              child: ChatBubble(
                isCurrentUser: isCurrentUser,
                message: data["message"],
                messageId: doc.id,
                userId: data["senderID"],
                timestamp: data["timestamp"],
                receiverID: widget.receiverID,
              ),
            ),
          );
        }

        return ListView(
          controller: _scrollController,
          children: messageWidgets,
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            isCurrentUser: isCurrentUser,
            message: data["message"],
            messageId: doc.id,
            userId: data["senderID"],
            timestamp: data["timestamp"],
            receiverID: widget.receiverID,
          ),
        ],
      ),
    );
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              hintText: "Type a message",
              obsecureText: false,
              controller: _messageController,
              focusNode: myFocusNode,
            ),
          ),

          IconButton(
            onPressed: () => _showAttachmentOptions(context),
            icon: Icon(Icons.attach_file),
          ),

          // send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
