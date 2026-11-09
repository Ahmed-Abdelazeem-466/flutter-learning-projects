import 'package:flutter/material.dart';
import 'package:language_learning_app/components/numbers_containers.dart';
import 'package:language_learning_app/models/model_num.dart';

class FamilyMembers extends StatelessWidget {
  const FamilyMembers({super.key});

  final List<Functions> FListNumber = const [
    Functions(
      sound: "sounds/family_members/grand father.wav",
      image: "assets/images/family_members/family_grandfather.png",
      enName: "Grand Father",
      jaName: "Ojīsan",
    ),
    Functions(
      sound: "sounds/family_members/grand mother.wav",
      image: "assets/images/family_members/family_grandmother.png",
      enName: "Grand Mother",
      jaName: "Sobo",
    ),
    Functions(
      sound: "sounds/family_members/father.wav",
      image: "assets/images/family_members/family_father.png",
      enName: "Father",
      jaName: "Chichioya",
    ),
    Functions(
      sound: "sounds/family_members/mother.wav",
      image: "assets/images/family_members/family_mother.png",
      enName: "Mother",
      jaName: "Hahaoya",
    ),
    Functions(
      sound: "sounds/family_members/son.wav",
      image: "assets/images/family_members/family_son.png",
      enName: "Son",
      jaName: "Musuko",
    ),
    Functions(
      sound: "sounds/family_members/daughter.wav",
      image: "assets/images/family_members/family_daughter.png",
      enName: "Daughter",
      jaName: "Musume",
    ),
    Functions(
      sound: "sounds/family_members/older bother.wav",
      image: "assets/images/family_members/family_older_brother.png",
      enName: "Older Brother",
      jaName: "Nīsan",
    ),
    Functions(
      sound: "sounds/family_members/older sister.wav",
      image: "assets/images/family_members/family_older_sister.png",
      enName: "Older Sister",
      jaName: "Ane",
    ),
    Functions(
      sound: "sounds/family_members/younger brohter.wav",
      image: "assets/images/family_members/family_younger_brother.png",
      enName: "Younger Brother",
      jaName: "Otōto",
    ),
    Functions(
      sound: "sounds/family_members/younger sister.wav",
      image: "assets/images/family_members/family_younger_sister.png",
      enName: "younger Sister",
      jaName: "Imōto",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 75, 51, 35),
        title: Text("Family Members", style: TextStyle(color: Colors.white)),
      ),

      body: ListView.builder(
        itemCount: FListNumber.length,
        itemBuilder: (context, index) {
          return ContainersOfNumbers(
            colors: Colors.green,
            number: FListNumber[index],
          );
        },
      ),
    );
  }
}
