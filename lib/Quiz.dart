import 'package:flutter/material.dart';
import 'result.dart';// this page will contain the final result
import 'dart:math'; // Import the dart:math library for shuffling

class Quiz extends StatefulWidget {
  Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<Map<String, String>> images = [
    {'path': 'assets/Lebanon.png', 'country': 'Lebanon', 'difficulty': 'easy'},
    {'path': 'assets/france.png', 'country': 'France', 'difficulty': 'easy'},
    {'path': 'assets/Spain.png', 'country': 'Spain', 'difficulty': 'easy'},
    {'path': 'assets/Syria.jpg', 'country': 'Syria', 'difficulty': 'easy'},
    {'path': 'assets/Palestine.jpg', 'country': 'Palestine', 'difficulty': 'easy'},
    {'path': 'assets/Tunisia.png', 'country': 'Tunisia', 'difficulty': 'medium'},
    {'path': 'assets/Turkey.jpg', 'country': 'Turkey', 'difficulty': 'medium'},
    {'path': 'assets/Russia.png', 'country': 'Russia', 'difficulty': 'medium'},
    {'path': 'assets/Somalia.png', 'country': 'Somalia', 'difficulty': 'medium'},
    {'path': 'assets/comoros.png', 'country': 'Comoros', 'difficulty': 'medium'},
    {'path': 'assets/Bhutan.png', 'country': 'Bhutan', 'difficulty': 'hard'},
    {'path': 'assets/Malta.jpg', 'country': 'Malta', 'difficulty': 'hard'},
    {'path': 'assets/Brunei.jpg', 'country': 'Brunei', 'difficulty': 'hard'},
    {'path': 'assets/Kyrgyztan.jpg', 'country': 'Kyrgyzstan', 'difficulty': 'hard'},
    {'path': 'assets/Sicily.jpg', 'country': 'Sicily', 'difficulty': 'hard'}
  ];


  List<Map<String, String>> easyImages = [];
  List<Map<String, String>> mediumImages = [];
  List<Map<String, String>> hardImages = [];
  List<Map<String, String>> currentImages = [];


  int i = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    for (var image in images) {
      if (image['difficulty'] == 'easy') {
        easyImages.add(image);
      } else if (image['difficulty'] == 'medium') {
        mediumImages.add(image);
      } else if (image['difficulty'] == 'hard') {
        hardImages.add(image);
      }
    }

    // Shuffle each list separately
    easyImages.shuffle();
    mediumImages.shuffle();
    hardImages.shuffle();

    // Combine the lists to form the currentImages list
    currentImages = [...easyImages, ...mediumImages, ...hardImages];
  }


  // Boolean variables to track button clicks
  Map<String, bool> clickedFlags = {
    'assets/Lebanon.png': false,
    'assets/france.png': false,
    'assets/Spain.png': false,
    'assets/Syria.jpg': false,
    'assets/Palestine.jpg': false,
    'assets/Tunisia.png': false,
    'assets/Turkey.jpg': false,
    'assets/Russia.png': false,
    'assets/Somalia.png': false,
    'assets/comoros.png': false,
    'assets/Bhutan.png': false,
    'assets/Malta.jpg': false,
    'assets/Brunei.jpg': false,
    'assets/Kyrgyztan.jpg': false,
    'assets/Sicily.jpg': false
  };

  void handleAnswer(String country) {
    setState(() {
      String currentImagePath = currentImages[i]['path']!;
      String currentCountry = currentImages[i]['country']!;
      if (currentCountry == country && !clickedFlags[currentImagePath]!) {
        count++;
        clickedFlags[currentImagePath] = true;
      }
      if (i != currentImages.length - 1) {
        i++;
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Result(result: count),
          ),
        );
      }
    });
  }


  Widget buildAnswerButton(String country) {
    return ElevatedButton(
      onPressed: () => handleAnswer(country),
      child: Text(country),
    );
  }

  String getLevel(int index) {
    if (index < easyImages.length) {
      return "Easy";
    } else if (index < easyImages.length + mediumImages.length) {
      return "Medium";
    } else {
      return "Hard";
    }
  }

  @override
  Widget build(BuildContext context) {
    String level = getLevel(i);
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlagQuiz v1.0'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text("Level: $level", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("Question ${i + 1} of ${currentImages.length}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (i > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        i--;
                      });
                    },
                    child: const Icon(Icons.navigate_before),
                  ),
                  Image.asset(currentImages[i]['path']!, width: 200),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (i != currentImages.length - 1) {
                        i++;
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Result(result: count),
                          ),
                        );
                      }
                    });
                  },
                  child: i < currentImages.length - 1 ? const Icon(Icons.navigate_next) : const Text("See Result?"),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              "Guess the Country",
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              alignment: WrapAlignment.center,
              children: [
                buildAnswerButton("Lebanon"),
                buildAnswerButton("France"),
                buildAnswerButton("Spain"),
                buildAnswerButton("Syria"),
                buildAnswerButton("Palestine"),
                buildAnswerButton("Tunisia"),
                buildAnswerButton("Turkey"),
                buildAnswerButton("Russia"),
                buildAnswerButton("Somalia"),
                buildAnswerButton("Comoros"),
                buildAnswerButton("Bhutan"),
                buildAnswerButton("Malta"),
                buildAnswerButton("Brunei"),
                buildAnswerButton("Kyrgyzstan"),
                buildAnswerButton("Sicily"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
