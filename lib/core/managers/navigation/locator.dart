import 'package:get/get.dart';
import 'package:maser/app/auth/presentation/viewmodels/auth_page_model.dart';
import 'package:maser/app/profile/presentation/viewmodels/profile_page_model.dart';
import 'package:maser/app/stories/presentation/viewmodels/stories_page_viewmodel.dart';

import '../../../app/auth/presentation/viewmodels/tabs_page_model.dart';
import '../../../app/mood_analysis/presentation/viewmodels/mood_analysis_page_model.dart';

void setupLocator() {
  //register view models
  Get.lazyPut(() => TabsPageModel());
  Get.lazyPut(() => MoodAnalysisPageModel());
  Get.lazyPut(() => AuthPageModel());

  Get.lazyPut(() => ProfilePageModel());
}

void removeLocatorOnLogout() {
  Get.delete<StoriesPageViewmodel>();
  Get.delete<MoodAnalysisPageModel>();
  Get.delete<ProfilePageModel>();
  Get.delete<TabsPageModel>();
}
