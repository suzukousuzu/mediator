import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditationr_app/generated/l10n.dart';
import 'package:meditationr_app/view/components/ripple_widget.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import '../../home_screen.dart';

class ThemeSettingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0,left: 8.0,right: 8.0,bottom: 8.0),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 8.0),
              Text(S.of(context).selectTheme),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                    themes.length,
                    (int index) => RippleWidget(
                        child: GridTile(
                          child: Image.asset(themes[index].imagePath,fit: BoxFit.fill,),
                          footer: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(themes[index].themeName)),
                          ),
                        ),
                        onTap: () {
                          _setTheme(context,index);
                          Navigator.pop(context);
                        }),
                  ),
                ),
              )
            ],
          ),
          //Positionedは位置を指定できる
          Positioned(
            top: 10.0,
          right: 10.0,
              child: RippleWidget(
                child: FaIcon(FontAwesomeIcons.windowClose),
                onTap: () => Navigator.pop(context),
              ))
        ],
      ),
    );
  }

  void _setTheme(BuildContext context, int index) {
    final viewModel = context.read<MainViewModel>();
    viewModel.setTheme(index);

  }
}
