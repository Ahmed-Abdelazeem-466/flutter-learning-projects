import 'package:flutter/material.dart';

void main() {
  runApp(PointsCounter());
}

class PointsCounter extends StatefulWidget {
  @override
  State<PointsCounter> createState() => _PointsCounterState();
}

class _PointsCounterState extends State<PointsCounter> {
  int TeamApoints = 0;
  int TeamBpoints = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Points counter"),
          backgroundColor: Color(0xffFEAB1D),
        ),
        body: Column(
          children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("Team A", style: TextStyle(fontSize: 45)),
                    Text("$TeamApoints", style: TextStyle(fontSize: 100)),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            Colors.orange, //خلى بالك كلو بيكتبها primary
                        foregroundColor:
                            Colors.black, //برضو بيكتبوها on primary
                      ),
                      onPressed: () {
                        setState(() {
                          TeamApoints++;
                        });
                      },
                      child: Text(
                        "Add 1 Point",
                        style: TextStyle(fontSize: 16.5),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            Colors.orange, //خلى بالك كلو بيكتبها primary
                        foregroundColor:
                            Colors.black, //برضو بيكتبوها on primary
                      ),
                      onPressed: () {
                        setState(() {
                          TeamApoints = TeamApoints + 2;
                        });
                      },
                      child: Text(
                        "Add 2 Point",
                        style: TextStyle(fontSize: 16.5),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            Colors.orange, //خلى بالك كلو بيكتبها primary
                        foregroundColor:
                            Colors.black, //برضو بيكتبوها on primary
                      ),
                      onPressed: () {
                        setState(() {
                          TeamApoints = TeamApoints + 3;
                        });
                      },
                      child: Text(
                        "Add 3 Point",
                        style: TextStyle(fontSize: 16.5),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 400,
                  child: VerticalDivider(
                    endIndent: 8,
                    indent: 22,
                    thickness: 2,
                    color: const Color.fromARGB(255, 204, 187, 187),
                  ),
                ),

                Column(
                  children: [
                    Text("Team B", style: TextStyle(fontSize: 45)),

                    Text("$TeamBpoints", style: TextStyle(fontSize: 100)),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.orange, //خلى بالك كلو بيكتبها primary
                        foregroundColor:
                            Colors.black, //برضو بيكتبوها on primary
                      ),
                      onPressed: () {
                        setState(() {
                          TeamBpoints++;
                        });
                      },
                      child: Text(
                        "Add 1 Point",
                        style: TextStyle(fontSize: 16.5),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.orange, //خلى بالك كلو بيكتبها primary
                        foregroundColor:
                            Colors.black, //برضو بيكتبوها on primary
                      ),
                      onPressed: () {
                        setState(() {
                          TeamBpoints = TeamBpoints + 2;
                        });
                      },
                      child: Text(
                        "Add 2 Point",
                        style: TextStyle(fontSize: 16.5),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.orange, //خلى بالك كلو بيكتبها primary
                        foregroundColor:
                            Colors.black, //برضو بيكتبوها on primary
                      ),
                      onPressed: () {
                        setState(() {
                          TeamBpoints = TeamBpoints + 3;
                        });
                      },
                      child: Text(
                        "Add 3 Point",
                        style: TextStyle(fontSize: 16.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 75),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fixedSize: Size(150, 40),
                backgroundColor: Colors.orange, //خلى بالك كلو بيكتبها primary
                foregroundColor: Colors.black, //برضو بيكتبوها on primary
              ),
              onPressed: () {
                setState(() {
                  TeamApoints = 0;
                  TeamBpoints = 0;
                });
              },
              child: Text("Rest", style: TextStyle(fontSize: 16.5)),
            ),
          ],
        ),
      ),
    );
  }
}
