import 'package:flutter/material.dart';
import 'package:meditationr_app/data_models/user_setting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditationr_app/generated/l10n.dart';
import 'package:meditationr_app/view/components/ripple_widget.dart';
import 'package:meditationr_app/view/components/show_modal_dialog.dart';
import 'package:meditationr_app/view/home/components/dialog/level_setting_dialog.dart';
import 'package:meditationr_app/view/home/components/dialog/theme_setting_dialog.dart';
import 'package:meditationr_app/view/home/components/dialog/time_setting_dialog.dart';
import 'package:meditationr_app/view/home/home_screen.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:meditationr_app/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../styles.dart';

class HeaderPart extends StatelessWidget {
  final UserSetting userSetting;

  HeaderPart({required this.userSetting});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: _createItem(context, userSetting.levelId, HeaderType.LEVEL)),
        Expanded(
            flex: 1,
            child: _createItem(context, userSetting.themeId, HeaderType.THEME)),
        Expanded(
            flex: 1,
            child:
            _createItem(context, userSetting.timeMinute, HeaderType.TIME)),
      ],
    );
  }

  Widget _createItem(BuildContext context, int id, HeaderType headerType) {
    return Selector<MainViewModel, RunningStatus>(
      selector: (context, viewModel) => viewModel.runningStatus,
      builder: (context, runningStatus, child) {
        return RippleWidget(
          //TODO
          onTap: (runningStatus != RunningStatus.BEFFORE_START &&
              runningStatus != RunningStatus.FINISHED)
              ? () =>
              Fluttertoast.showToast(
                  msg: S
                      .of(context)
                      .showSettingsAgain,
                  backgroundColor: dialogBackgroundColor,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM)
              : () => _openSettingDialog(context, headerType),
          child: Column(
            children: [
              _createHeaderItemIcon(headerType),
              SizedBox(
                height: 10.0,
              ),
              _displayIconText(context, id, headerType),
            ],
          ),
        );
      },
    );
  }

  Widget _createHeaderItemIcon(HeaderType headerType) {
    Widget icon;
    switch (headerType) {
      case HeaderType.LEVEL:
        icon = FaIcon(FontAwesomeIcons.disease);
        break;
      case HeaderType.THEME:
        icon = FaIcon(FontAwesomeIcons.image);
        break;
      case HeaderType.TIME:
        icon = FaIcon(FontAwesomeIcons.stopwatch);
        break;
    }
    return icon;
  }

  Widget _displayIconText(BuildContext context, int id, HeaderType headerType) {
    Widget displayTextWidget;
    switch (headerType) {
      case HeaderType.LEVEL:
        displayTextWidget = Text(levels[id].levelName);
        break;
      case HeaderType.THEME:
        displayTextWidget = Text(themes[id].themeName);
        break;
      case HeaderType.TIME:
        displayTextWidget = Selector<MainViewModel, String>(
            selector: (context, viewModel) => viewModel.remainingTimeString!,
            builder: (context, timeString, child) =>
            displayTextWidget = Text(timeString));
        break;
    }
    return displayTextWidget;
  }

  _openSettingDialog(BuildContext context, HeaderType headerType) {
    switch (headerType) {
      case HeaderType.LEVEL:
        showModalDialog(
            context: context,
            dialogWidget: LevelSettingDialog(),
            isScrollable: false);
        break;
      case HeaderType.THEME:
        showModalDialog(
            context: context,
            dialogWidget: ThemeSettingDialog(),
            isScrollable: true);
        break;
      case HeaderType.TIME:
        showModalDialog(
            context: context,
            dialogWidget: TimeSettingDialog(),
            isScrollable: false);
        break;
    }
  }
}
