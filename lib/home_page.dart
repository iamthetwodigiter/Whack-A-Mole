import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whack_a_mole/widgets/board.dart';
import 'package:whack_a_mole/widgets/life.dart';

enum Difficulty { easy, medium, hard }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int score = 0;
  int lifeCount = 3;
  bool isGameStarted = false;
  Difficulty difficulty = Difficulty.easy;

  void updateScore() {
    setState(() {
      score++;
    });
  }

  void decreaseLife() {
    setState(() {
      lifeCount--;
    });
    if (lifeCount < 1) {
      resetGame();
    }
  }

  void resetGame() {
    setState(() {
      score = 0;
      lifeCount = 3;
      isGameStarted = false;
    });
  }

  void startGame() {
    setState(() {
      score = 0;
      lifeCount = 3;
      isGameStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Whack-A-Mole'),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Life(lifeCount: lifeCount),
                  // const Text('High : 0'),
                  Text('Score : $score'),
                ],
              ),
              const Spacer(),
              Board(
                onMoleHit: () => updateScore(),
                onWrongHit: () => decreaseLife(),
                isGameStarted: isGameStarted,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  if (!isGameStarted) {
                    startGame();
                  } else {
                    resetGame();
                  }
                },
                child: Text(
                  isGameStarted ? 'Reset' : 'Start',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
