import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: MyGame()),
            ValueListenableBuilder<bool>(
              valueListenable: MyGame.isGameOver,
              builder: (context, isGameOver, child) {
                if (!isGameOver) return const SizedBox.shrink();
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Game Over',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      IconButton(
                        onPressed: () => MyGame.resetGame(),
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 48,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
