import 'package:flutter/material.dart';

import '../styles.dart';

//どこからでも使えるトップレベル関数
showModalDialog(
    {required BuildContext context,
    required Widget dialogWidget,
    required bool isScrollable}) {
  showModalBottomSheet(
      context: context,
      builder: (context) => dialogWidget,
      isScrollControlled: isScrollable,
      backgroundColor: dialogBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0))));
}
