class MeisoTime {
  final int timeMinute;
  final String timeDisplayString;

//<editor-fold desc="Data Methods">

  const MeisoTime({
    required this.timeMinute,
    required this.timeDisplayString,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeisoTime &&
          runtimeType == other.runtimeType &&
          timeMinute == other.timeMinute &&
          timeDisplayString == other.timeDisplayString);

  @override
  int get hashCode => timeMinute.hashCode ^ timeDisplayString.hashCode;

  @override
  String toString() {
    return 'MeisoTime{' +
        ' timeMinute: $timeMinute,' +
        ' timeDisplayString: $timeDisplayString,' +
        '}';
  }

  MeisoTime copyWith({
    int? timeMinute,
    String? timeDisplayString,
  }) {
    return MeisoTime(
      timeMinute: timeMinute ?? this.timeMinute,
      timeDisplayString: timeDisplayString ?? this.timeDisplayString,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeMinute': this.timeMinute,
      'timeDisplayString': this.timeDisplayString,
    };
  }

  factory MeisoTime.fromMap(Map<String, dynamic> map) {
    return MeisoTime(
      timeMinute: map['timeMinute'] as int,
      timeDisplayString: map['timeDisplayString'] as String,
    );
  }

//</editor-fold>
}