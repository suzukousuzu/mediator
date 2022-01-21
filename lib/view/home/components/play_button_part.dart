import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditationr_app/utils/constants.dart';
import 'package:meditationr_app/view/components/ripple_widget.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';

class PlayButtonPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final remainingStatus = context.select<MainViewModel, RunningStatus>(
        (viewModel) => viewModel.runningStatus);

    final isTimerCanceled = context
        .select<MainViewModel, bool>((viewModel) => viewModel.isTimerCanceled);
    return Stack(
      children: [
        //1かい
        Center(
          child: RippleWidget(
              child: _playLargIcon(context, remainingStatus),
              onTap: () => _onPlayButtonPressed(context, remainingStatus)),
        ),
        //2かい
        Positioned(
            left: 16.0,
            bottom: 0.0,
            child: (remainingStatus == RunningStatus.PAUSE && isTimerCanceled)
                ? RippleWidget(
                    child: Icon(
                      FontAwesomeIcons.stopCircle,
                      size: smallStopIconSize,
                    ),
                    onTap: () => _onStopButtonPressed(context))
                : Container())
      ],
    );
  }

  _onPlayButtonPressed(BuildContext context, RunningStatus remainingStatus) {
    final viewModel = context.read<MainViewModel>();
    if (remainingStatus == RunningStatus.BEFFORE_START) {
      viewModel.startMeditation();
    } else if (remainingStatus == RunningStatus.PAUSE) {
     if(viewModel.isTimerCanceled) viewModel.resumMeditation();
    } else if (remainingStatus == RunningStatus.FINISHED) {
     if(viewModel.isTimerCanceled) viewModel.resetMeditation();
    } else {
      viewModel.pauseMeditation();
    }
  }

  //TODO
  _onStopButtonPressed(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    viewModel.resetMeditation();
  }

  Widget _playLargIcon(BuildContext context, RunningStatus remainingStatus) {
    Icon icon;
    if (remainingStatus == RunningStatus.BEFFORE_START ||
        remainingStatus == RunningStatus.PAUSE) {
      icon = Icon(
        FontAwesomeIcons.playCircle,
        size: largePlayIconSize,
      );
    } else if (remainingStatus == RunningStatus.FINISHED) {
      icon = Icon(
        FontAwesomeIcons.stopCircle,
        size: largePlayIconSize,
      );
    } else {
      icon = Icon(
        FontAwesomeIcons.pause,
        size: largePlayIconSize,
      );
    }
    return icon;
  }
}
