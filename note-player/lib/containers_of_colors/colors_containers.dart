import 'package:flutter/material.dart';
import 'package:tunes_player_app/containers_of_colors/second_qaleb.dart';

class ColorsContainers extends StatelessWidget {
  const ColorsContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 50, 50, 50),
          title: Text("Flutter Tune", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),

        body: const Column(
          children: [
            Qaleb(color: Color(0xff4B6043), sound: "note1.wav"),
            Qaleb(color: Color(0xff658354), sound: "note2.wav"),
            Qaleb(color: Color(0xff75975E), sound: "note3.wav"),
            Qaleb(color: Color(0xff87AB69), sound: "note4.wav"),
            Qaleb(color: Color(0xff95BB72), sound: "note5.wav"),
            Qaleb(color: Color(0xffA3C585), sound: "note6.wav"),
            Qaleb(color: Color(0xffB3CF99), sound: "note7.wav"),
          ],
        ),
      ),
    );
  }
}
