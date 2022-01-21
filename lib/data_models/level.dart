const LEVEL_ID_EASY = 0;
const LEVEL_ID_NORMAL = 1;
const LEVEL_ID_MID = 2;
const LEVEL_ID_HIGH = 3;

class Level {
  final int levelId;
  final String levelName;
  final String explanation;
  final String beltPath;
  final int totalInterval;
  final int inhaleInterval;
  final int holdInterval;
  final int exhaleInterval;

//<editor-fold desc="Data Methods">

 const Level({
    required this.levelId,
    required this.levelName,
    required this.explanation,
    required this.beltPath,
    required this.totalInterval,
    required this.inhaleInterval,
    required this.holdInterval,
    required this.exhaleInterval,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Level &&
          runtimeType == other.runtimeType &&
          levelId == other.levelId &&
          levelName == other.levelName &&
          explanation == other.explanation &&
          beltPath == other.beltPath &&
          totalInterval == other.totalInterval &&
          inhaleInterval == other.inhaleInterval &&
          holdInterval == other.holdInterval &&
          exhaleInterval == other.exhaleInterval);

  @override
  int get hashCode =>
      levelId.hashCode ^
      levelName.hashCode ^
      explanation.hashCode ^
      beltPath.hashCode ^
      totalInterval.hashCode ^
      inhaleInterval.hashCode ^
      holdInterval.hashCode ^
      exhaleInterval.hashCode;

  @override
  String toString() {
    return 'Level{' +
        ' levelId: $levelId,' +
        ' levelName: $levelName,' +
        ' explanation: $explanation,' +
        ' beltPath: $beltPath,' +
        ' totalInterval: $totalInterval,' +
        ' inhaleInterval: $inhaleInterval,' +
        ' holdInterval: $holdInterval,' +
        ' exhaleInterval: $exhaleInterval,' +
        '}';
  }

  Level copyWith({
    int? levelId,
    String? levelName,
    String? explanation,
    String? beltPath,
    int? totalInterval,
    int? inhaleInterval,
    int? holdInterval,
    int? exhaleInterval,
  }) {
    return Level(
      levelId: levelId ?? this.levelId,
      levelName: levelName ?? this.levelName,
      explanation: explanation ?? this.explanation,
      beltPath: beltPath ?? this.beltPath,
      totalInterval: totalInterval ?? this.totalInterval,
      inhaleInterval: inhaleInterval ?? this.inhaleInterval,
      holdInterval: holdInterval ?? this.holdInterval,
      exhaleInterval: exhaleInterval ?? this.exhaleInterval,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'levelId': this.levelId,
      'levelName': this.levelName,
      'explanation': this.explanation,
      'beltPath': this.beltPath,
      'totalInterval': this.totalInterval,
      'inhaleInterval': this.inhaleInterval,
      'holdInterval': this.holdInterval,
      'exhaleInterval': this.exhaleInterval,
    };
  }

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      levelId: map['levelId'] as int,
      levelName: map['levelName'] as String,
      explanation: map['explanation'] as String,
      beltPath: map['beltPath'] as String,
      totalInterval: map['totalInterval'] as int,
      inhaleInterval: map['inhaleInterval'] as int,
      holdInterval: map['holdInterval'] as int,
      exhaleInterval: map['exhaleInterval'] as int,
    );
  }

//</editor-fold>
}
