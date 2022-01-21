import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meditationr_app/data_models/theme.dart';
import 'package:meditationr_app/data_models/user_setting.dart';
import 'package:meditationr_app/models/managers/ad_manager.dart';
import 'package:meditationr_app/models/managers/in_app_purchase_manager.dart';
import 'package:meditationr_app/models/managers/sound_manager.dart';
import 'package:meditationr_app/models/repository/shared_prefs_rewpository.dart';
import 'package:meditationr_app/utils/constants.dart';
import 'package:meditationr_app/utils/functions.dart';
import 'package:meditationr_app/view/home/home_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class MainViewModel extends ChangeNotifier {
  final SharedPrefRepository sharedPrefRepository;
  final SoundManager soundManager;
  final InAppPurchaseManager inAppPurchaseManager;
  final AdManager adManager;

  UserSetting? userSetting;
  RunningStatus runningStatus = RunningStatus.BEFFORE_START;

  int remainingTimeSeconds = 0;

  //remainingTimeSecondsが変更される度にconvertTimeFormatが走る
  //getterでどこからでもremainingTimeStringにアクセス可能
  String? get remainingTimeString => convertTimeFormat(remainingTimeSeconds);

  int intervalRemainingSeconds = INITIAL_INTERVAL;

  //経過時間
  int timeElapsedInOneCycle = 0;

  bool isTimerCanceled = true;

  //TODO
  double get volume => soundManager.bellVolume * 100;

  MainViewModel(
      {required this.sharedPrefRepository,
      required this.soundManager,
      required this.inAppPurchaseManager,
      required this.adManager}) {
    //インスタンス生成時に初期化処理をしたい
    adManager..initAdmob()..initBannerAd()..initInterstitialAd();
  }

  Future<void> skipIntro() async {
    await sharedPrefRepository.skipIntro();
  }

  Future<bool> isSkipIntroScreen() async {
    return await sharedPrefRepository.isSkipIntroScreen();
  }

  Future<void> getUserSettings() async {
    userSetting = await sharedPrefRepository.getUserSettings();
    //秒に直すために60をかける
    remainingTimeSeconds = userSetting!.timeMinute * 60;
    print(remainingTimeString);
    notifyListeners();
  }

  Future<void> setLevel(int index) async {
    await sharedPrefRepository.setLevel(index);
    //sharedpreferenceに登録した後は再びuserデータをとってくる必要がある
    getUserSettings();
  }

  Future<void> setTime(int timeMinute) async {
    await sharedPrefRepository.setTime(timeMinute);
    getUserSettings();
  }

  Future<void> setTheme(int index) async {
    await sharedPrefRepository.setTheme(index);
    getUserSettings();
  }

  void startMeditation() {
    runningStatus = RunningStatus.ON_START;
    notifyListeners();
    intervalRemainingSeconds = INITIAL_INTERVAL;
    int cnt = 0;

    //開始前カウントダウンタイマー処理
    Timer.periodic(Duration(seconds: 1), (timer) async {
      cnt += 1;
      intervalRemainingSeconds = INITIAL_INTERVAL - cnt;
      if (intervalRemainingSeconds <= 0) {
        timer.cancel();
        await prepareSounds();
        _startMeditationTimer();
      } else if (runningStatus == RunningStatus.PAUSE) {
        timer.cancel();
        resetMeditation();
      }
      notifyListeners();
    });
  }

  //音をロードする
  Future<void> prepareSounds() async {
    final levelId = userSetting!.levelId;
    final themeId = userSetting!.levelId;

    //themeIdがTHEME_ID_SILENCEでない時にtrueになる
    final isNeedBgm = themeId != THEME_ID_SILENCE;
    final bgmPath = isNeedBgm ? themes[themeId].soundPath : null;
    final bellPath = levels[levelId].beltPath;

    await soundManager.prepareSounds(bgmPath, bellPath, isNeedBgm);
  }

  //音をスタートする
  void _startBgm() async {
    final levelId = userSetting!.levelId;
    final themeId = userSetting!.levelId;

    //themeIdがTHEME_ID_SILENCEでない時にtrueになる
    final isNeedBgm = themeId != THEME_ID_SILENCE;
    final bgmPath = isNeedBgm ? themes[themeId].soundPath : null;
    final bellPath = levels[levelId].beltPath;

    await soundManager.startBgm(bgmPath, bellPath, isNeedBgm);
  }

  void _stopBgm() {
    final themeId = userSetting!.levelId;
    //themeIdがTHEME_ID_SILENCEでない時にtrueになる
    final isNeedBgm = themeId != THEME_ID_SILENCE;

    soundManager.stopBgm(isNeedBgm);
  }

  void resumMeditation() {
    _startMeditationTimer();
  }

  void resetMeditation() {
    runningStatus == RunningStatus.BEFFORE_START;
    intervalRemainingSeconds = INITIAL_INTERVAL;
    remainingTimeSeconds = userSetting!.timeMinute * 60;
    timeElapsedInOneCycle = 0;
    notifyListeners();
  }

  void pauseMeditation() {
    runningStatus = RunningStatus.PAUSE;
    notifyListeners();
  }

  //TODO 音量調整
  void changeVolume(double newVolume) {
    soundManager.changeVolume(newVolume);
    notifyListeners();
  }

  //TODO 瞑想処理
  void _startMeditationTimer() {
    remainingTimeSeconds = _adjustMeditationTime(remainingTimeSeconds);
    notifyListeners();

    timeElapsedInOneCycle = 0;
    _evalutateStatus();
    _startBgm();

    Timer.periodic(Duration(seconds: 1), (timer) {
      isTimerCanceled = false;
      remainingTimeSeconds--;
      notifyListeners();

      if (runningStatus != RunningStatus.BEFFORE_START &&
          runningStatus != RunningStatus.ON_START &&
          runningStatus != RunningStatus.PAUSE) {
        _evalutateStatus();
      }

      if (runningStatus == RunningStatus.PAUSE) {
        timer.cancel();
        isTimerCanceled = true;
        _stopBgm();
      } else if (runningStatus == RunningStatus.FINISHED) {
        timer.cancel();
        isTimerCanceled = true;
        _stopBgm();
        _ringFinalGong();
      }
      notifyListeners();
    });
  }

  int _adjustMeditationTime(int remainingTimeSeconds) {
    final totalInterval = levels[userSetting!.levelId].totalInterval;
    //あまりを出す
    final remainder = remainingTimeSeconds.remainder(totalInterval);
    if (remainder >= totalInterval / 2) {
      return remainingTimeSeconds + (totalInterval - remainder);
    } else {
      return remainingTimeSeconds - remainder;
    }
  }

  //瞑想が回っているとkのステータスの計算
  void _evalutateStatus() {
    if (remainingTimeSeconds == 0) {
      runningStatus = RunningStatus.FINISHED;
      return;
    }
    final inhaleInterval = levels[userSetting!.levelId].inhaleInterval;
    final holdInterval = levels[userSetting!.levelId].holdInterval;
    final totalInterval = levels[userSetting!.levelId].totalInterval;

    if (timeElapsedInOneCycle >= 0 && timeElapsedInOneCycle < inhaleInterval) {
      runningStatus = RunningStatus.INHALE;
      intervalRemainingSeconds = inhaleInterval - timeElapsedInOneCycle;
    } else if (timeElapsedInOneCycle < inhaleInterval + holdInterval) {
      runningStatus = RunningStatus.HOLD;
      intervalRemainingSeconds = (inhaleInterval + holdInterval) - holdInterval;
    } else if (timeElapsedInOneCycle < totalInterval) {
      runningStatus = RunningStatus.EXHALE;
      intervalRemainingSeconds = totalInterval - timeElapsedInOneCycle;
    }
    timeElapsedInOneCycle = (timeElapsedInOneCycle >= totalInterval - 1)
        ? 0
        : timeElapsedInOneCycle++;
  }

  void _ringFinalGong() {
    soundManager.ringFinalGong();
  }

  @override
  void dispose() {
    super.dispose();
    soundManager.dispose();
    adManager.dispose();
  }

  loadBannerAd() {
    adManager.loadBannerAd();
  }

  void loadInterstitialAd() {
    adManager.loadInterstitialAd();
  }
}
