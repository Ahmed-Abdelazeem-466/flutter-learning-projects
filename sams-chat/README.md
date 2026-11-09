# SAMS Chat

A real-time chat app built with Flutter and Firebase.

**Origin:** a software engineering course project. It was built by following Mitch Koko's YouTube chat-app tutorial, and extra features were added with the help of ChatGPT. It is a learning project, not an original design.

## Features

- Email and password sign up and login (Firebase Authentication)
- One-to-one chat with live updates (Cloud Firestore)
- Image sharing from the gallery or camera, and document sharing
- Date labels in the conversation ("Today", "Yesterday")
- Block and unblock users, report users, delete messages
- Light and dark theme (Provider)

## Project structure

```
lib/
  components/   reusable widgets (chat bubble, text field, drawer, ...)
  models/       message model
  pages/        login, register, home, chat, settings, blocked users
  services/     auth and chat logic (Firebase, Cloudinary)
  themes/       light and dark themes
```

Chat rooms are identified by the two user IDs sorted and joined, so both users always open the same room.

## Setup

The private Firebase configuration is not included, so you need your own Firebase project.

1. Install Flutter and the Firebase CLI.
2. Create a Firebase project and enable **Email/Password** sign in, **Cloud Firestore** and **Storage**.
3. In this folder run `flutterfire configure`. It creates `lib/firebase_options.dart` and the Android config file.
4. Optional: create a [Cloudinary](https://cloudinary.com) account with an unsigned upload preset, then replace `YOUR_CLOUDINARY_CLOUD_NAME` and `YOUR_UNSIGNED_UPLOAD_PRESET` in `lib/services/chat/chat_service.dart` and `lib/services/photos and documents/cloudinary_service.dart`.
5. Run `flutter pub get` and `flutter run`.

Set Firestore and Storage rules that require a signed-in user. Do not leave them in test mode.

## Known limitations

- Blocking only hides users in the app. A blocked user can still send messages.
- Gallery images use Cloudinary, while camera photos and documents use Firebase Storage.
- The message list builds all messages at once, so very long chats would be slow.
- There are no automated tests.
