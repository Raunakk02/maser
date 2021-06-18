import 'package:get_it/get_it.dart';

import '../../../app/presentation/viewmodels/auth/auth_page_model.dart';
import '../../../app/presentation/viewmodels/mood_analysis/mood_analysis_page_model.dart';
import '../../../app/presentation/viewmodels/tabs_page_model.dart';
import '../../services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());

  //register view models
  locator.registerFactory(() => TabsPageModel());
  locator.registerFactory(() => MoodAnalysisPageModel());
  locator.registerFactory(() => AuthPageModel());
}
