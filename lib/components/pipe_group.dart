import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/configuration.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  final _random = Random();

   PipeGroup();
    @override
  Future<void> onLoad() async {
      position.x = gameRef.size.x;

      // * gameRef.size.y: height of screen
      // * Config.groundHeight: height of the ground
      final heightMinusGround = gameRef.size.y - Config.groundHeight;
      // * spacing between the pipes
      final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
      final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);
      addAll([
        Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
        Pipe(pipePosition: PipePosition.bottom, height: heightMinusGround - (centerY + spacing / 2)),
      ]);
    }

    @override
  void update(double dt) {
      super.update(dt);
      position.x -= Config.gameSpeed * dt;

      if (position.x < -10) {
        removeFromParent();
        updateScore();
      }

      if (gameRef.isHit) {
        removeFromParent();
        gameRef.isHit = false;
      }
    }

    void updateScore() {
      gameRef.bird.score += 1;
      FlameAudio.play(Assets.point);
    }
}