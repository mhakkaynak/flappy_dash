import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/components/background.dart';

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
    await _createBackground();
  }

  Future<void> _createPlayer() async {
    _player.position = Vector2(size.x / 2, size.y / 2);
    _player.size = Vector2(size.x / 4, size.y / 4);
    _player.anchor = Anchor.center;
    _player.priority = 1;
    add(_player);
  }

  Future<void> _createBackground() async {
    final background = Background();
    background.position = Vector2(size.x / 2, size.y / 2);
    background.size = Vector2(size.x, size.y);
    background.anchor = Anchor.center;
    background.priority = 0;
    add(background);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _player.fly();
    super.onTapDown(event);
  }
}
