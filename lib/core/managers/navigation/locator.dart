import 'package:get/get.dart';

import '../../../app/auth/presentation/viewmodels/auth_page_model.dart';
import '../../../app/auth/presentation/viewmodels/tabs_page_model.dart';
import '../../../app/mood_analysis/presentation/viewmodels/mood_analysis_page_model.dart';

void setupLocator() {
  //register view models
  Get.lazyPut(() => TabsPageModel());
  Get.lazyPut(() => AuthPageModel());
  Get.lazyPut(() => MoodAnalysisPageModel());
}
