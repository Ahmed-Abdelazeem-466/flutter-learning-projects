# Note Player

A tiny Flutter app with seven colored bars. Tapping a bar plays a note using the `audioplayers` package.

**Origin:** a practice project from learning Flutter basics (widgets, layout, playing audio from assets).

## Not included

The sound files are not published. To run the app, add seven audio files named `note1.wav` to `note7.wav` to the `assets/` folder.

## Run

```
flutter pub get
flutter run
```

## Notes

- The code is in `lib/`, about 90 lines in total.
- A new audio player is created on every tap. Reusing one player and disposing of it would be the next improvement.
