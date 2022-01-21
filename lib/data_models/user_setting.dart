class UserSetting {
  final bool isSkipIntroScreen;
  final int levelId;
  final int themeId;
  final int timeMinute;

//<editor-fold desc="Data Methods">

  const UserSetting({
    required this.isSkipIntroScreen,
    required this.levelId,
    required this.themeId,
    required this.timeMinute,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          runtimeType == other.runtimeType &&
          isSkipIntroScreen == other.isSkipIntroScreen &&
          levelId == other.levelId &&
          themeId == other.themeId &&
          timeMinute == other.timeMinute);

  @override
  int get hashCode =>
      isSkipIntroScreen.hashCode ^
      levelId.hashCode ^
      themeId.hashCode ^
      timeMinute.hashCode;

  @override
  String toString() {
    return 'UserSetting{' +
        ' isSkipIntroScreen: $isSkipIntroScreen,' +
        ' levelId: $levelId,' +
        ' themeId: $themeId,' +
        ' timeMinute: $timeMinute,' +
        '}';
  }

  UserSetting copyWith({
    bool? isSkipIntroScreen,
    int? levelId,
    int? themeId,
    int? timeMinute,
  }) {
    return UserSetting(
      isSkipIntroScreen: isSkipIntroScreen ?? this.isSkipIntroScreen,
      levelId: levelId ?? this.levelId,
      themeId: themeId ?? this.themeId,
      timeMinute: timeMinute ?? this.timeMinute,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isSkipIntroScreen': this.isSkipIntroScreen,
      'levelId': this.levelId,
      'themeId': this.themeId,
      'timeMinute': this.timeMinute,
    };
  }

  factory UserSetting.fromMap(Map<String, dynamic> map) {
    return UserSetting(
      isSkipIntroScreen: map['isSkipIntroScreen'] as bool,
      levelId: map['levelId'] as int,
      themeId: map['themeId'] as int,
      timeMinute: map['timeMinute'] as int,
    );
  }

//</editor-fold>
}