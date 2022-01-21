import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditationr_app/generated/l10n.dart';
import 'package:meditationr_app/utils/constants.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialogPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).iconTheme;
    final runningStatus = context.select<MainViewModel, RunningStatus>(
            (viewModel) => viewModel.runningStatus);
    return runningStatus != RunningStatus.BEFFORE_START
        ? Container()
        : SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: iconTheme.color,
      overlayColor: Colors.white.withOpacity(0.4),
      children: [
        SpeedDialChild(
          child: FaIcon(FontAwesomeIcons.donate),
          label: S.of(context).donation,
          labelBackgroundColor: Colors.grey,
          onTap: () => _donate(context)
        ),
        SpeedDialChild(
            child: FaIcon(FontAwesomeIcons.ad),
            label: S.of(context).deleteAd,
             labelBackgroundColor: Colors.grey,
            onTap: () => _deleteAd(context)
        ),
        SpeedDialChild(
            child: FaIcon(FontAwesomeIcons.subscript),
            label: S.of(context).subscription,
            labelBackgroundColor: Colors.grey,
            onTap: () => _subscription(context)
        ),
        SpeedDialChild(
            child: FaIcon(FontAwesomeIcons.undo),
            label: S.of(context).recoverPurchase,
            labelBackgroundColor: Colors.grey,
            onTap: () => _recoverPurchase(context)
        ),
      ],
    );
  }

  //TODO
  _donate(BuildContext context) {}

  _deleteAd(BuildContext context) {}

  _subscription(BuildContext context) {}

  _recoverPurchase(BuildContext context) {}
}
