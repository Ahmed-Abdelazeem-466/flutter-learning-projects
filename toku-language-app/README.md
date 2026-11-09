# Toku: Japanese Learning App

A small Flutter app for learning basic Japanese vocabulary. Each word has an image, the Japanese reading, the English meaning and an audio button.

**Origin:** a practice project from a student activity.

## Screens

- Numbers
- Family members
- Colors
- Phrases

## Not included

The audio and image files are not published, so the app will not play sounds or show images until you add your own files to these folders:

```
assets/images/numbers, family_members, colors
assets/sounds/numbers, family_members, colors, phrases
```

File names are listed in the page files under `lib/Screens/`.

## Run

```
flutter pub get
flutter run
```

## Notes

- The word lists are written directly inside the page widgets.
- The Japanese readings have not been reviewed by a native speaker.
