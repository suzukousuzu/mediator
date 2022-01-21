import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meditationr_app/data_models/level.dart';
import 'package:meditationr_app/data_models/theme.dart';
import 'package:meditationr_app/data_models/time.dart';
import 'package:meditationr_app/data_models/user_setting.dart';
import 'package:meditationr_app/generated/l10n.dart';
import 'package:meditationr_app/models/managers/ad_manager.dart';
import 'package:meditationr_app/view/home/components/decoration_background.dart';
import 'package:meditationr_app/view/home/components/header_part.dart';
import 'package:meditationr_app/view/home/components/play_button_part.dart';
import 'package:meditationr_app/view/home/components/speed_dialog_part.dart';
import 'package:meditationr_app/view/home/components/status_display_part.dart';
import 'package:meditationr_app/view/home/components/volum_slider_part.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

//トップレベル
List<Level> levels = [];
List<MeisoTheme> themes = [];
List<MeisoTime> times = [];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    levels = setLevels(context);
    themes = setMeisoThemes(context);
    times = setMeisoTimes(context);

    final viewModel = context.read<MainViewModel>();

    Future(() {
      //ビルドメソッドが回る前にバナー広告をロードしないといけない
      viewModel
        ..getUserSettings()
        ..loadBannerAd();
    });
    return SafeArea(
      child: Scaffold(
          floatingActionButton: SpeedDialogPart(),
          //userSettingが変更された時のみ再描画
          body: Selector<MainViewModel, UserSetting?>(
            selector: (context, viewModel) => viewModel.userSetting,
            builder: (context, userSettings, child) {
              return userSettings == null
                  ? Center(child: CircularProgressIndicator())
                  : Stack(
                fit: StackFit.expand,
                children: [
                  //一階
                  //TODO グラデーション付き背景画像
                  DecorationBackground(theme: themes[userSettings.themeId],),
                  //2階
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        HeaderPart(userSetting: userSettings,),
                        StatusDisplayPart(),
                        PlayButtonPart(),
                        VolumeSliderPart(),
                      ],
                    ),
                  ),
                  //3かい
                  Selector<MainViewModel, AdManager>(
                    selector: (context, viewModel) => viewModel.adManager,
                    builder: (context, adManager, child) {
                      final bannerAd = adManager.bannerAd;
                      return Positioned(
                          bottom: 8.0,
                          left: 20.0,
                          right: 20.0,
                          child: (bannerAd == null) ? Container(
                            width: 0.0, height: 0.0,
                          ) : Container(
                            width: bannerAd.size.width.toDouble(),
                            height: bannerAd.size.height.toDouble(),
                            child: AdWidget(ad: bannerAd,),

                          ));
                    },
                  )
                ],
              );
            },
          )),
    );
  }

  List<Level> setLevels(BuildContext context) {
    return [
      Level(
        levelId: LEVEL_ID_EASY,
        levelName: S
            .of(context)
            .levelEasy,
        explanation: S
            .of(context)
            .levelSelectEasy,
        beltPath: "assets/sounds/bells_easy.mp3",
        totalInterval: 12,
        inhaleInterval: 4,
        holdInterval: 4,
        exhaleInterval: 4,
      ),
      Level(
        levelId: LEVEL_ID_NORMAL,
        levelName: S
            .of(context)
            .levelNormal,
        explanation: S
            .of(context)
            .levelSelectNormal,
        beltPath: "assets/sounds/bells_normal.mp3",
        totalInterval: 16,
        inhaleInterval: 4,
        holdInterval: 4,
        exhaleInterval: 8,
      ),
      Level(
        levelId: LEVEL_ID_MID,
        levelName: S
            .of(context)
            .levelMid,
        explanation: S
            .of(context)
            .levelSelectMid,
        beltPath: "assets/sounds/bells_mid.mp3",
        totalInterval: 20,
        inhaleInterval: 4,
        holdInterval: 8,
        exhaleInterval: 8,
      ),
      Level(
        levelId: LEVEL_ID_HIGH,
        levelName: S
            .of(context)
            .levelHigh,
        explanation: S
            .of(context)
            .levelSelectHigh,
        beltPath: "assets/sounds/bells_advanced.mp3",
        totalInterval: 28,
        inhaleInterval: 4,
        holdInterval: 16,
        exhaleInterval: 8,
      ),
    ];
  }

  List<MeisoTheme> setMeisoThemes(BuildContext context) {
    return [
      MeisoTheme(
        themeId: THEME_ID_SILENCE,
        themeName: S
            .of(context)
            .themeSilence,
        imagePath: "assets/images/silence.jpg",
        soundPath: null,
      ),
      MeisoTheme(
        themeId: THEME_ID_CAVE,
        themeName: S
            .of(context)
            .themeCave,
        imagePath: "assets/images/cave.jpg",
        soundPath: "assets/sounds/bgm_cave.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_SPRING,
        themeName: S
            .of(context)
            .themeSpring,
        imagePath: "assets/images/spring.jpg",
        soundPath: "assets/sounds/bgm_spring.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_SUMMER,
        themeName: S
            .of(context)
            .themeSummer,
        imagePath: "assets/images/summer.jpg",
        soundPath: "assets/sounds/bgm_summer.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_AUTUMN,
        themeName: S
            .of(context)
            .themeAutumn,
        imagePath: "assets/images/autumn.jpg",
        soundPath: "assets/sounds/bgm_autumn.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_STREAM,
        themeName: S
            .of(context)
            .themeStream,
        imagePath: "assets/images/stream.jpg",
        soundPath: "assets/sounds/bgm_stream.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_WIND_BELLS,
        themeName: S
            .of(context)
            .themeWindBell,
        imagePath: "assets/images/wind_bell.jpg",
        soundPath: "assets/sounds/bgm_wind_bell.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_BONFIRE,
        themeName: S
            .of(context)
            .themeBonfire,
        imagePath: "assets/images/bonfire.jpg",
        soundPath: "assets/sounds/bgm_bonfire.mp3",
      ),
    ];
  }

  List<MeisoTime> setMeisoTimes(BuildContext context) {
    return [
      MeisoTime(
        timeDisplayString: S
            .of(context)
            .min5,
        timeMinute: 5,
      ),
      MeisoTime(
        timeDisplayString: S
            .of(context)
            .min10,
        timeMinute: 10,
      ),
      MeisoTime(
        timeDisplayString: S
            .of(context)
            .min15,
        timeMinute: 15,
      ),
      MeisoTime(
        timeDisplayString: S
            .of(context)
            .min20,
        timeMinute: 20,
      ),
      MeisoTime(
        timeDisplayString: S
            .of(context)
            .min30,
        timeMinute: 30,
      ),
      MeisoTime(
        timeDisplayString: S
            .of(context)
            .min60,
        timeMinute: 60,
      ),
    ];
  }
}
