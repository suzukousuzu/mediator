import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class VolumeSliderPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final volumes = context.select<MainViewModel,double>((viewModel) => viewModel.volume);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.volumeMute),
          Expanded(
            child: Slider(
              min: 0,
              max: 100,
              divisions: 50,
              label: volumes.round().toString(),
              inactiveColor: Colors.white.withOpacity(0.3),
              activeColor: Colors.white,
              value: volumes,
              onChanged: (newVolume) {
                 _changeVolume(context,newVolume);
              },


            ),
          ),
          Icon(FontAwesomeIcons.volumeUp),
        ],
      ),
    );

  }

  //TODO 音声調整
  void _changeVolume(BuildContext context, double newVolume) {
    final viewModel = context.read<MainViewModel>();
    viewModel.changeVolume(newVolume);
  }
}
