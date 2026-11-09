import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Qaleb extends StatelessWidget {
  const Qaleb({super.key, required this.color, required this.sound});
  final Color color;
  final String sound;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          final player = AudioPlayer();
          player.play(AssetSource(sound));
        },

        child: Container(color: color),
      ),
    );
  }
}


    // Attributes(color:Colors.red , sound: "soun"),
    // Attributes(color:Colors.amber , sound: 'sound'),
    // Attributes(color:Colors.yellow , sound: 'sound'),
    // Attributes(color:Colors.green , sound: 'sound'),
    // Attributes(color:Color.fromARGB(255, 10, 147, 101) , sound: 'sound'),
    // Attributes(color:Colors.blue , sound: 'sound'),
    // Attributes(color:Colors.purple , sound: 'sound'),