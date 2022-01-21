import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meditationr_app/di/providers.dart';
import 'package:meditationr_app/view/home/home_screen.dart';
import 'package:meditationr_app/view/intro/intro_screen.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() =>
    runApp(MultiProvider(providers: globalProviders, child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    return MaterialApp(
      title: "Meditation",
      //多言語対応のおまじない
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData.dark(),
      home: FutureBuilder(
        future: viewModel.isSkipIntroScreen(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          }else {
            return IntroScreen();
          }


    },
      ),
    );
  }
}
