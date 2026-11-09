import 'package:flutter/material.dart';
import 'package:tunes_player_app/containers_of_colors/colors_containers.dart';

void main() {
  runApp(TunesPlayer());
}

class TunesPlayer extends StatelessWidget {
  const TunesPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorsContainers();
  }
}
