import 'package:flutter/material.dart';
import 'package:meditationr_app/generated/l10n.dart';
import 'package:meditationr_app/utils/constants.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class StatusDisplayPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final runningStatus = context.select<MainViewModel, RunningStatus>(
        (viewModel) => viewModel.runningStatus);

    return Column(
      children: [
        Text(
          _upperSmallText(context, runningStatus),
          style: TextStyle(fontSize: 24.0),
        ),
        Selector<MainViewModel, int>(
          selector: (context, viewModel) => viewModel.intervalRemainingSeconds,
          builder: (context, intervalRemainingSeconds, child) {
            return Text(
              _lowerLargeText(context, runningStatus, intervalRemainingSeconds),
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            );
          },
        )
      ],
    );
  }

  String _upperSmallText(BuildContext context, RunningStatus runningStatus) {
    var displayText = "";
    switch (runningStatus) {
      case RunningStatus.BEFFORE_START:
        displayText = "";
        break;
      case RunningStatus.ON_START:
        displayText = S.of(context).startsIn;
        break;
      case RunningStatus.INHALE:
        displayText = S.of(context).inhale;
        break;
      case RunningStatus.HOLD:
        displayText = S.of(context).hold;
        break;
      case RunningStatus.EXHALE:
        displayText = S.of(context).exhale;
        break;
      case RunningStatus.PAUSE:
        displayText = S.of(context).pause;
        break;
      case RunningStatus.FINISHED:
        displayText = S.of(context).finished;
        loadInterstitialAd(context);
        break;
    }
    return displayText;
  }

  String _lowerLargeText(BuildContext context, RunningStatus runningStatus,
      int intervalRemainingSeconds) {
    var displaySeconds = "";
    if (runningStatus == RunningStatus.BEFFORE_START) {
      displaySeconds = "";
    } else if (runningStatus == RunningStatus.FINISHED) {
      displaySeconds = S.of(context).finished;
    } else {
      displaySeconds = intervalRemainingSeconds.toString();
    }
    return displaySeconds;
  }

  void loadInterstitialAd(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    viewModel.loadInterstitialAd();
  }
}
