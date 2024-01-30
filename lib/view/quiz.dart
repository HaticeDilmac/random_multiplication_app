import 'dart:math';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int number1 = 0;
  int number2 = 0;
  int totalNumber = 0;
  List<int> numbers = [];
  bool userClicked = false;
  int currentQuestion = 1; // Şu anki soru numarası
  int totalQuestions = 10; // Toplam soru sayısı

  @override
  void initState() {
    super.initState();
    randomNumber();
  }

//random değerleri alır ve çarpar
//random değer listesini oluşturur.
  void randomNumber() {
    setState(() {
      number1 = Random().nextInt(10);
      number2 = Random().nextInt(10);
      totalNumber = number1 * number2;

      numbers = [
        Random().nextInt(100),
        totalNumber,
        Random().nextInt(100),
        Random().nextInt(100),
      ];

      numbers.shuffle();
      userClicked = false;
    });
  }

//Değer kontolü yapılır
  void checkAnswer(int selectedAnswer) {
    setState(() {
      userClicked = true;
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: selectedAnswer == totalNumber
                ? const Text("Doğru!")
                : const Text("Yanlış!"),
            content: selectedAnswer == totalNumber
                ? const Text("Tebrikler, doğru cevap!")
                : Text("Üzgünüm, yanlış cevap. Doğru cevap: $totalNumber"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (userClicked) {
                    if (currentQuestion < totalQuestions) {
                      currentQuestion++;
                      randomNumber();
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Quiz Tamamlandı!"),
                            content: const Text(
                                "Tüm soruları doğru cevapladınız. Tebrikler!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // İsterseniz quiz'i sıfırlayabilirsiniz.
                                  setState(() {
                                    currentQuestion = 1;
                                  });
                                },
                                child: const Text("Quiz'i Sıfırla"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: const Text("Devam Et"),
              ),
            ],
          );
        });
  }

  final Random random = Random(); //Random ifadesi

  final List<Image> selectedImage = [
    Image.asset(
      'assets/img/p1.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p2.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p3.jpg',
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
    Image.asset(
      'assets/img/p6.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p7.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p8.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p9.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/img/p10.jpg',
      fit: BoxFit.cover,
    ),
  ];

  Image getRandomImage() {
    return selectedImage[random.nextInt(selectedImage.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 167, 191),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(
        //           totalQuestions == currentQuestion ? selectedImage : ''),
        //       fit: BoxFit.cover),
        // ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: getRandomImage().image, // Use the image property
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      currentQuestion.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "$number1 x $number2 = ?",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: numbers.asMap().entries.map((entry) {
                  final option = entry.value;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => checkAnswer(option),
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: userClicked && option == totalNumber
                                ? Colors.green
                                : userClicked
                                    ? Colors.red
                                    : Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(option.toString()),
                              Icon(
                                Icons.check_circle,
                                color: userClicked && option == totalNumber
                                    ? Colors.green
                                    : userClicked
                                        ? Colors.red
                                        : Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
