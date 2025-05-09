import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'components/player.dart';

class MyGame extends FlameGame with TapCallbacks {
  late Player _player;

  MyGame() {
    _player = Player();
  }

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    await startGame();
    super.onLoad();
  }

  Future<void> startGame() async {
    await _createPlayer();
  }

  Future<void> _createPlayer() async {
    _player.position = Vector2(size.x / 2, size.y / 2);
    _player.size = Vector2(size.x / 4, size.y / 4);
    _player.anchor = Anchor.center;
    add(_player);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _player.fly();
    super.onTapDown(event);
  }
}
