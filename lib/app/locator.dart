import 'package:get_it/get_it.dart';
import 'package:maser/core/services/navigation_service.dart';
import 'package:maser/core/viewmodels/mood_analysis/mood_analysis_page_model.dart';
import 'package:maser/core/viewmodels/tabs_page_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());

  //register view models
  locator.registerFactory(() => TabsPageViewModel());
  locator.registerFactory(() => MoodAnalysisPageModel());
}
