import 'package:flutter/material.dart';
import 'package:meditationr_app/data_models/user_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREF_KEY_IS_SKIP_INTRO = "isSkipIntro";
const PREF_KEY_IS_LEVEL_ID = "levelId";
const PREF_KEY_IS_THEME_ID = "themId";
const PREF_KEY_IS_TIME = "time";

class SharedPrefRepository {
  Future<bool> skipIntro() async {
    final pref = await SharedPreferences.getInstance();
    return pref.setBool(PREF_KEY_IS_SKIP_INTRO, true);
  }

  Future<bool> isSkipIntroScreen() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(PREF_KEY_IS_SKIP_INTRO) ?? false;
  }

  Future<UserSetting> getUserSettings() async {
    final pref = await SharedPreferences.getInstance();
    return UserSetting(
        isSkipIntroScreen: pref.getBool(PREF_KEY_IS_SKIP_INTRO) ?? false,
        levelId: pref.getInt(PREF_KEY_IS_LEVEL_ID) ?? 0,
        themeId: pref.getInt(PREF_KEY_IS_THEME_ID) ?? 0,
        timeMinute: pref.getInt(PREF_KEY_IS_TIME) ?? 5);
  }

  Future<bool>setLevel(int index) async{
    final pref = await SharedPreferences.getInstance();
    return pref.setInt(PREF_KEY_IS_LEVEL_ID, index);



  }

  Future<bool> setTime(int timeMinute) async{
    final pref = await SharedPreferences.getInstance();
    return pref.setInt(PREF_KEY_IS_TIME,timeMinute);

  }

  Future<bool>setTheme(int index) async{
    final pref = await SharedPreferences.getInstance();
    return pref.setInt(PREF_KEY_IS_THEME_ID, index);

  }
}
