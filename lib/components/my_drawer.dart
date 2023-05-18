import 'package:flutter/material.dart';
import 'package:hotnewsquiz/components/normal_text.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as per your preference
      child: Drawer(
        child: Container(
          //To change the color of Drawer, Container must be inside
          color: const Color.fromARGB(255, 60, 15, 116),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  //add action
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: const [
                      Icon(Icons.home, size: 20, color: Colors.white),
                      SizedBox(width: 10),
                      NormalText('ホーム'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //add action
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: const [
                      Icon(Icons.email, size: 20, color: Colors.white),
                      SizedBox(width: 10),
                      NormalText('お問合わせ'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //add action
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: const [
                      Icon(Icons.policy, size: 20, color: Colors.white),
                      SizedBox(width: 10),
                      NormalText('規約'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
