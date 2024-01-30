import 'dart:math';

import 'package:bp_miray/view/quiz.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Random random = Random(); //Random ifadesi

  final List<Image> customImage = [
    Image.asset(
      'assets/img/p1.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p2.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p4.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p5.jpg',
      fit: BoxFit.cover,
    ),
  ];

  Image getRandomImage() {
    return customImage[random.nextInt(customImage.length)];
  }

  @override
  Widget build(BuildContext context) {
    Image randomImage = getRandomImage();

    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: randomImage,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Hoşgeldin Miray',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Çarpım tablosunu Öğrenmeye Hazır mısın?',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizPage()),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      'Hazırım',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
