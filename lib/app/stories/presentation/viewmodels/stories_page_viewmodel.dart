import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:maser/app/stories/data/datasources/stories_remote_datasource.dart';
import 'package:maser/app/stories/data/repositories/stories_repository_impl.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/domain/usecases/add_story_to_favorite.dart';
import 'package:maser/app/stories/domain/usecases/delete_story_from_favorite.dart'
    as delStoryFromFav;
import 'package:maser/app/stories/domain/usecases/get_fav_stories.dart';
import 'package:maser/app/stories/domain/usecases/get_stories.dart';
import 'package:maser/app/stories/presentation/viewmodels/add_stories_viewmodel.dart';
import 'package:maser/core/enums/filter_stories.dart';
import 'package:maser/core/managers/navigation/route_constants.dart';
import 'package:maser/core/services/network/network_info.dart';
import 'package:maser/core/usecases/usecase.dart';

class StoriesPageViewmodel extends GetxController {
  var stories = <Story>[].obs;
  var favStoriesIds = <String>[].obs;
  var isFetchingStories = false.obs;
  var shownStories = <Story>[].obs;

  StoriesPageViewmodel() {
    getStories(isInit: true);
  }

  final _getStories = GetStories(
    StoriesRepositoryImpl(
      remoteDatasource: StoriesRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  final _addStoryToFavorite = AddStoryToFavorite(
    StoriesRepositoryImpl(
      remoteDatasource: StoriesRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  final _deleteStoryFromFavorite = delStoryFromFav.DeleteStoryFromFavorite(
    StoriesRepositoryImpl(
      remoteDatasource: StoriesRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  final _getFavStories = GetFavStories(
    StoriesRepositoryImpl(
      remoteDatasource: StoriesRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  Future<void> getStories({bool isInit = false}) async {
    if (isInit) isFetchingStories.value = true;
    stories.value = [];
    final result = await _getStories(NoParams());
    await fetchFavStories();

    if (result.isLeft()) {
      Get.showSnackbar(GetBar(
        message: 'Something went wrong',
      ));
    } else {
      stories.value = result.getOrElse(null);
      print(stories.length);
      storiesToShow();
      print(stories.length);
    }
    if (isInit) isFetchingStories.value = false;

    return;
  }

  Future<void> fetchFavStories() async {
    favStoriesIds.value = [];
    final result = await _getFavStories(NoParams());
    if (result.isLeft()) {
      Get.showSnackbar(GetBar(
        message: 'Something went wrong',
      ));
    } else {
      favStoriesIds.value = result.getOrElse(null);
    }
    return;
  }

  Future<void> addStoryToFav(String storyId) async {
    if (favStoriesIds.contains(storyId)) {
      return;
    }
    favStoriesIds.add(storyId);
    final result = await _addStoryToFavorite(Params(storyId: storyId));
    if (result.isLeft()) {
      favStoriesIds.remove(storyId);
      Get.showSnackbar(GetBar(
        message: 'Something went wrong',
      ));
    }
    return;
  }

  Future<void> deleteStoryFromFavorite(String storyId) async {
    if (!favStoriesIds.contains(storyId)) {
      return;
    }
    favStoriesIds.remove(storyId);
    final result = await _deleteStoryFromFavorite(
        delStoryFromFav.Params(storyId: storyId));
    if (result.isLeft()) {
      favStoriesIds.add(storyId);
      Get.showSnackbar(GetBar(
        message: 'Something went wrong',
      ));
    }
    return;
  }

  void toggleFavButton(String storyId) {
    if (favStoriesIds.contains(storyId)) {
      deleteStoryFromFavorite(storyId);
    } else {
      addStoryToFav(storyId);
    }
  }

  void storiesToShow({FilterStories filter = FilterStories.all}) {
    shownStories.value = [];
    List<Story> _temp = stories;

    if (filter == FilterStories.all) {
      shownStories.value = _temp;
    } else {
      _temp.forEach((element) {
        if (favStoriesIds.contains(element.id)) {
          shownStories.add(element);
        }
      });
    }
  }

  void navigateToAddStoriesPage() {
    Get.toNamed(RouteConstants.addStoriesPage).then((value) {
      Get.delete<AddStoiesViewModel>();
      getStories();
    });
  }
}
