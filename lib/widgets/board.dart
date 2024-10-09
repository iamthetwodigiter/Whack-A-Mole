import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Board extends StatefulWidget {
  final VoidCallback onMoleHit;
  final VoidCallback onWrongHit;
  final bool isGameStarted;
  const Board({
    super.key,
    required this.onMoleHit,
    required this.onWrongHit,
    required this.isGameStarted,
  });

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<int> boardIndices = [];
  List<int> molesHit = [];
  Timer? timer;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (widget.isGameStarted) {
      start();
    }
  }

  @override
  void didUpdateWidget(covariant Board oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isGameStarted && !oldWidget.isGameStarted) {
      start();
    } else if (!widget.isGameStarted && oldWidget.isGameStarted) {
      resetBoard();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void start() {
    _startResetTimer();
  }

  void resetBoard() {
    timer?.cancel();
    setState(() {
      boardIndices.clear();
      molesHit.clear();
    });
  }

  List<int> displayMole() {
    int n = Random().nextInt(3) + 1;
    List<int> boardIndices = [];

    for (int i = 0; i <= n; i++) {
      boardIndices.add(Random().nextInt(9));
    }
    return boardIndices;
  }

  void _startResetTimer() {
    Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      setState(() {
        boardIndices.clear();
        molesHit.clear();
        boardIndices = displayMole();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.5,
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.deepOrange[400],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amberAccent,
              ),
              child: boardIndices.contains(index)
                  ? !molesHit.contains(index)
                      ? Image.asset('assets/images/mole.png')
                      : Image.asset('assets/images/hit.png')
                  : null,
            ),
            onTap: () async {
              if (await Vibration.hasVibrator() != null) {
                await Vibration.vibrate(duration: 100);
              }
              if (boardIndices.contains(index) && !molesHit.contains(index)) {
                await audioPlayer.play(AssetSource('audio/smash.mp3'));
                setState(() {
                  molesHit.add(index);
                  widget.onMoleHit();
                });
              } else if (!boardIndices.contains(index)) {
                setState(() {
                  widget.onWrongHit();
                });
              }
            },
          );
        },
        itemCount: 9,
      ),
    );
  }
}
