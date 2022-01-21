import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundManager {
  Soundpool _soundPool = Soundpool.fromOptions();

  AssetsAudioPlayer _bellPlayer = AssetsAudioPlayer();
  AssetsAudioPlayer _bgmPlayer = AssetsAudioPlayer();

  int soundId = 0;
  double bellVolume = 0.2;

  SoundManager() {
    init();
  }

  void init() async {
    soundId = await _loadSound("assets/sounds/gong_sound.mp3");
    _soundPool.setVolume(soundId: soundId, volume: bellVolume);
  }

  Future<void> prepareSounds(
      String? bgmPath, String bellPath, bool isNeedBgm) async {
    //ベル
    await _bellPlayer.open(Audio(bellPath),
        volume: bellVolume, loopMode: LoopMode.single,
        autoStart: false
        );
    //BGM
    if (isNeedBgm) {
      await _bgmPlayer.open(Audio(bgmPath!),
          loopMode: LoopMode.single, autoStart: false);
    }
  }

  _loadSound(String soundPath) {
    return rootBundle.load(soundPath).then((value) => _soundPool.load(value));
  }

  startBgm(String? bgmPath, String bellPath, bool isNeedBgm) {
    _bellPlayer.setVolume(bellVolume);
    _bellPlayer.play();
    _bgmPlayer.play();
  }

  void stopBgm(bool isNeedBgm) {
    _bellPlayer.stop();
    if(isNeedBgm) {
      _bgmPlayer.stop();
    }
  }

  void ringFinalGong() {
    _soundPool.play(soundId);
  }

  void changeVolume(double newVolume) {
    bellVolume = newVolume / 100;
    _bellPlayer.setVolume(bellVolume);
    _soundPool.setVolume(soundId: soundId,volume: bellVolume);

  }

  void dispose() {
    _soundPool.release();
    _bellPlayer.dispose();
    _bgmPlayer.dispose();
  }
}
