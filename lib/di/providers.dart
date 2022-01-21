
import 'package:meditationr_app/models/managers/ad_manager.dart';
import 'package:meditationr_app/models/managers/in_app_purchase_manager.dart';
import 'package:meditationr_app/models/managers/sound_manager.dart';
import 'package:meditationr_app/models/repository/shared_prefs_rewpository.dart';
import 'package:meditationr_app/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<SharedPrefRepository>(create: (context) => SharedPrefRepository()),
  Provider<AdManager>(create: (context) => AdManager()),
  Provider<SoundManager>(create: (context) => SoundManager()),
  Provider<InAppPurchaseManager>(create: (context) => InAppPurchaseManager())
];

List<SingleChildWidget> dependentModels = [];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<MainViewModel>(
      create: (context) => MainViewModel(
          adManager: context.read<AdManager>(),
          inAppPurchaseManager: context.read<InAppPurchaseManager>(),
          sharedPrefRepository: context.read<SharedPrefRepository>(),
          soundManager: context.read<SoundManager>()))
];
