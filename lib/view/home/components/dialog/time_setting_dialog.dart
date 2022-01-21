import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditationr_app/generated/l10n.dart';
import 'package:meditationr_app/view/home/home_screen.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../styles.dart';

class TimeSettingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timeSelectedButton = List.generate(
      times.length,
      (index) => TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text(
          times[index].timeDisplayString,
          style: TextStyle(fontSize: 18.0),
        ),
        onPressed: () {
          _setTime(context, times[index].timeMinute);
          Navigator.pop(context);
        },
      ),
    );
    return Container(
      height: 150.0 + 50.0,
      child: Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          Text(S.of(context).selectTime),
          SizedBox(
            height: 8.0,
          ),
          Table(
            children: [
              TableRow(children: [
                timeSelectedButton[0],
                timeSelectedButton[1],
                timeSelectedButton[2],
              ]),
              TableRow(children: [
                timeSelectedButton[3],
                timeSelectedButton[4],
                timeSelectedButton[5],
              ]),
            ],
          )
        ],
      ),
    );
  }

  void _setTime(BuildContext context, int timeMinute) {
    //TODO
    final viewModel = context.read<MainViewModel>();
    viewModel.setTime(timeMinute);
    Fluttertoast.showToast(
        msg: S.of(context).timeAdjusted,
        backgroundColor: dialogBackgroundColor,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM);
  }
}
