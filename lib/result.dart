import 'package:flutter/material.dart';
import 'Quiz.dart';

class Result extends StatelessWidget {
  final int? result;

  Result({Key? key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200,),
            Text("You got $result/15"),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Quiz(),
                  ),
                );
              },
              child: const Text("Play again"),
            ),
          ],
        ),
      ),
    );
  }
}
