import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/models/model_num.dart';

class ContainersOfNumbers extends StatelessWidget {
  const ContainersOfNumbers({
    super.key,
    required this.number,
    required this.colors,
  });
  final Functions number;
  final Color colors;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors,
      height: 100,
      child: Row(
        children: [
          Container(
            color: Color.fromARGB(255, 253, 255, 202),
            child: Image.asset(number.image),
          ),

          Padding(padding: const EdgeInsets.only(left: 15)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number.jaName,
                style: TextStyle(fontSize: 23, color: Colors.white),
              ),
              Text(
                number.enName,
                style: TextStyle(fontSize: 23, color: Colors.white),
              ),
            ],
          ),

          Spacer(flex: 1),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                final player = AudioPlayer();
                player.play(AssetSource(number.sound));
              },
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 35),
            ),
          ),
        ],
      ),
    );
  }
}

class PhrasesContainer extends StatelessWidget {
  const PhrasesContainer({super.key, required this.ph, required this.colors});

  final PhraseFunctions ph;
  final Color colors;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors,
      height: 100,
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.only(left: 15)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ph.jaName,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Text(
                ph.enName,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ],
          ),

          Spacer(flex: 1),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                final player = AudioPlayer();
                player.play(AssetSource(ph.sound));
              },
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 35),
            ),
          ),
        ],
      ),
    );
  }
}
