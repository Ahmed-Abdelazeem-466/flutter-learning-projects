import 'package:flutter/material.dart';
import 'package:language_learning_app/components/numbers_containers.dart';
import 'package:language_learning_app/models/model_num.dart';

class NumbersPage extends StatelessWidget {
  const NumbersPage({super.key});

  final List<Functions> ListNumber = const [
    Functions(
      sound: "sounds/numbers/number_one_sound.mp3",
      image: "assets/images/numbers/number_one.png",
      enName: "One",
      jaName: "Ichi",
    ),
    Functions(
      sound: "sounds/numbers/number_two_sound.mp3",
      image: "assets/images/numbers/number_two.png",
      enName: "Two",
      jaName: "Ni",
    ),
    Functions(
      sound: "sounds/numbers/number_three_sound.mp3",
      image: "assets/images/numbers/number_three.png",
      enName: "Three",
      jaName: "San",
    ),
    Functions(
      sound: "sounds/numbers/number_four_sound.mp3",
      image: "assets/images/numbers/number_four.png",
      enName: "Four",
      jaName: "Shi",
    ),
    Functions(
      sound: "sounds/numbers/number_five_sound.mp3",
      image: "assets/images/numbers/number_five.png",
      enName: "Five",
      jaName: "Go",
    ),
    Functions(
      sound: "sounds/numbers/number_six_sound.mp3",
      image: "assets/images/numbers/number_six.png",
      enName: "Six",
      jaName: "Roku",
    ),
    Functions(
      sound: "sounds/numbers/number_seven_sound.mp3",
      image: "assets/images/numbers/number_seven.png",
      enName: "Seven",
      jaName: "Sebun",
    ),
    Functions(
      sound: "sounds/numbers/number_eight_sound.mp3",
      image: "assets/images/numbers/number_eight.png",
      enName: "Eight",
      jaName: "Hachi",
    ),
    Functions(
      sound: "sounds/numbers/number_nine_sound.mp3",
      image: "assets/images/numbers/number_nine.png",
      enName: "Nine",
      jaName: "Ku",
    ),
    Functions(
      sound: "sounds/numbers/number_ten_sound.mp3",
      image: "assets/images/numbers/number_ten.png",
      enName: "Ten",
      jaName: "Juu",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 75, 51, 35),
        title: Text("Numbers", style: TextStyle(color: Colors.white)),
      ),

      body: ListView.builder(
        itemCount: ListNumber.length,
        itemBuilder: (context, index) {
          return ContainersOfNumbers(
            colors: Colors.amber,
            number: ListNumber[index],
          );
        },
      ),
    );
  }

  // List<Widget> getList(List<Number> Numbers) {
  //   List<ContainersOfNumbers> ListNumber = [];
  //   for (int i = 0; i < Numbers.length; i++) {
  //     ListNumber.add(ContainersOfNumbers(number: Numbers[i]));
  //   }
  //   return ListNumber;
  // }
  // دى بتقوم زى بس اتقل انا خليتها هنا تبقى تستفاد بيها  listViwe.builder
}
