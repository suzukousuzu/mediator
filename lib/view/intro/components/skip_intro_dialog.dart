import 'package:flutter/material.dart';
import 'package:meditationr_app/generated/l10n.dart';

class SkipIntroDialog extends StatelessWidget {
  final VoidCallback onSkipped;
  SkipIntroDialog({required this.onSkipped});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Center(
              child: Text(
            S.of(context).skipIntroConfirm,
            textAlign: TextAlign.center,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text(S.of(context).yes),
                onPressed:  onSkipped,
              ),
              TextButton(
                child: Text(S.of(context) .no),
                onPressed: () => Navigator.pop(context),
              ),

            ],
          )
        ],
      ),
    );
  }
}
