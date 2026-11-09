import 'package:flutter/material.dart';
import 'package:language_learning_app/Screens/colors_page.dart';
import 'package:language_learning_app/Screens/family_page.dart';
import 'package:language_learning_app/Screens/numbers_page.dart';
import 'package:language_learning_app/Screens/phrases_page.dart';
import 'package:language_learning_app/components/Category_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 253, 255, 202),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 75, 51, 35),
          title: Text("Toku", style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          children: [
            Category(
              text: "Numbers",
              color: Colors.amber,
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NumbersPage();
                    },
                  ),
                );
              },
            ),

            Category(
              text: "Family Members",
              color: Colors.green,
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FamilyMembers();
                    },
                  ),
                );
              },
            ),

            Category(
              text: "Colors",
              color: Color.fromARGB(255, 126, 68, 177),
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CoulorsPage();
                    },
                  ),
                );
              },
            ),

            Category(
              text: "Phrases",
              color: const Color.fromARGB(255, 22, 109, 123),
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PhrasesPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
