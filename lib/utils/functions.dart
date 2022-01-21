String? convertTimeFormat(int seconds) {
  Duration duration = Duration(seconds: seconds);
  //数字を文字列に変えて左から二桁、二桁にないものは0をあてる
  String twoDigits(int n) => n.toString().padLeft(2,"0");
  //remainderは60で割ったあまり。今回の場合は分は60より大きくなることはないのでいらない
  String minuteString = twoDigits(duration.inMinutes);
  String secondsString = twoDigits(duration.inSeconds.remainder(60));

  return "$minuteString : $secondsString";



}
