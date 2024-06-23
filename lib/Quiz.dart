import 'package:flutter/material.dart';
import 'result.dart';// this page will contain the final result
import 'dart:math'; // Import the dart:math library for shuffling

class Quiz extends StatefulWidget {
  Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final Map<String, String> images = {
    'assets/Lebanon.png': 'easy',
    'assets/france.png': 'easy',
    'assets/Spain.png': 'easy',
    'assets/Syria.jpg': 'easy',
    'assets/Palestine.jpg': 'easy',
    'assets/Tunisia.png': 'medium',
    'assets/Turkey.jpg': 'medium',
    'assets/Russia.png': 'medium',
    'assets/Somalia.png': 'medium',
    'assets/comoros.png': 'medium',
    'assets/Bhutan.png': 'hard',
    'assets/Malta.jpg': 'hard',
    'assets/Brunei.jpg': 'hard',
    'assets/Kyrgyztan.jpg': 'hard',
    'assets/Sicily.jpg': 'hard'
  };

  List<String> easyImages = [];
  List<String> mediumImages = [];
  List<String> hardImages = [];
  List<String> currentImages = [];

  int i = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    images.forEach((key, value) {
      if (value == 'easy') {
        easyImages.add(key);
      } else if (value == 'medium') {
        mediumImages.add(key);
      } else if (value == 'hard') {
        hardImages.add(key);
      }
    });

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
      String currentImage = currentImages[i];
      if (currentImage.contains(country.toLowerCase()) && !clickedFlags[currentImage]!) {
        count++;
        clickedFlags[currentImage] = true;
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
                Image.asset(currentImages[i], width: 200),
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
