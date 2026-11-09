import 'package:flutter/material.dart';
import 'package:language_learning_app/components/numbers_containers.dart';
import 'package:language_learning_app/models/model_num.dart';

class PhrasesPage extends StatelessWidget {
  const PhrasesPage({super.key});

  final List<PhraseFunctions> PhrasesList = const [
    PhraseFunctions(
      sound: "sounds/phrases/are_you_coming.wav",
      enName: "Are you coming?",
      jaName: "Kimasu ka?",
    ),
    PhraseFunctions(
      sound: "sounds/phrases/dont_forget_to_subscribe.wav",
      enName: "Don't forget to subscribe",
      jaName: "Kōdoku suru no o wasurenaide kudasai",
    ),
    PhraseFunctions(
      sound: "sounds/phrases/how_are_you_feeling.wav",
      enName: "How are you feeling",
      jaName: "Chōshi wa dō desu ka?",
    ),
    PhraseFunctions(
      sound: "sounds/phrases/i_love_anime.wav",
      enName: "I love anime",
      jaName: "Anime ga daisuki desu",
    ),
    PhraseFunctions(
      sound: "sounds/phrases/i_love_programming.wav",
      enName: "I love programming",
      jaName: "Puroguramingu ga daisuki desu",
    ),
    PhraseFunctions(
      sound: "sounds/phrases/programming_is_easy.wav",
      enName: "Programming is easy",
      jaName: "Puroguramingu wa kantan desu",
    ),
    PhraseFunctions(
      sound: "sounds/phrases/what_is_your_name.wav",
      enName: "What is your name",
      jaName: "Onamae wa nan desu ka?",
    ),
    PhraseFunctions(
      sound: "sounds/phrases/where_are_you_going.wav",
      enName: "Where are you going",
      jaName: "Doko ni ikimasu ka?",
    ),
    PhraseFunctions(
      sound: "sounds/phrases/yes_im_coming.wav",
      enName: "Yes I'm coming",
      jaName: "Hai, ikimasu",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 75, 51, 35),
        title: Text("Phrases", style: TextStyle(color: Colors.white)),
      ),

      body: ListView.builder(
        itemCount: PhrasesList.length,
        itemBuilder: (context, index) {
          return PhrasesContainer(
            colors: const Color.fromARGB(255, 22, 109, 123),
            ph: PhrasesList[index],
          );
        },
      ),
    );
  }
}
