
import 'package:flame/game.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/screen/game_over_screen.dart';
import 'package:flappy_bird/screen/main_menu_screen.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FlappyBirdGame();
  runApp(
    GameWidget(
        game: game,
      initialActiveOverlays: const [MainMenuScreen.id],
      overlayBuilderMap: {
          'mainMenu': (context, _) => MainMenuScreen(game: game),
          'gameOver': (context, _) => GameOverScreen(game: game),

      },
    ),

  );
}


