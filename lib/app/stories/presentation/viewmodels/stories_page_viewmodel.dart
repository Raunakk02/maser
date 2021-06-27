import 'package:get/get.dart';
import 'package:maser/app/stories/presentation/viewmodels/add_stories_viewmodel.dart';
import 'package:maser/core/managers/navigation/route_constants.dart';

class StoriesPageViewmodel extends GetxController {
  void navigateToAddStoriesPage() {
    Get.toNamed(RouteConstants.addStoriesPage).then((value) {
      Get.delete<AddStoiesViewModel>();
    });
  }
}
