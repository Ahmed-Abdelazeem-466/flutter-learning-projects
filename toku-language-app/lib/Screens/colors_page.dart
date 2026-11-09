import 'package:flutter/material.dart';
import 'package:language_learning_app/components/numbers_containers.dart';
import 'package:language_learning_app/models/model_num.dart';

class CoulorsPage extends StatelessWidget {
  const CoulorsPage({super.key});

  final List<Functions> CListNumber = const [
    Functions(
      sound: "sounds/colors/black.wav",
      image: "assets/images/colors/color_black.png",
      enName: "Black",
      jaName: "Burakku",
    ),
    Functions(
      sound: "sounds/colors/brown.wav",
      image: "assets/images/colors/color_brown.png",
      enName: "Brown",
      jaName: "Chairo",
    ),
    Functions(
      sound: "sounds/colors/dusty yellow.wav",
      image: "assets/images/colors/color_dusty_yellow.png",
      enName: "Dusty Yellow",
      jaName: "Hokori ppoi Kiiro",
    ),
    Functions(
      sound: "sounds/colors/gray.wav",
      image: "assets/images/colors/color_gray.png",
      enName: "Gray",
      jaName: "Gure",
    ),
    Functions(
      sound: "sounds/colors/green.wav",
      image: "assets/images/colors/color_green.png",
      enName: "Green",
      jaName: "Midori",
    ),
    Functions(
      sound: "sounds/colors/red.wav",
      image: "assets/images/colors/color_red.png",
      enName: "Red",
      jaName: "Aka",
    ),
    Functions(
      sound: "sounds/colors/white.wav",
      image: "assets/images/colors/color_white.png",
      enName: "White",
      jaName: "Shiroi",
    ),
    Functions(
      sound: "sounds/colors/yellow.wav",
      image: "assets/images/colors/yellow.png",
      enName: "Yellow",
      jaName: "Kiiro",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 75, 51, 35),
        title: Text("Colors", style: TextStyle(color: Colors.white)),
      ),

      body: ListView.builder(
        itemCount: CListNumber.length,
        itemBuilder: (context, index) {
          return ContainersOfNumbers(
            colors: const Color.fromARGB(255, 126, 68, 177),
            number: CListNumber[index],
          );
        },
      ),
    );
  }
}
