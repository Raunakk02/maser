import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:maser/app/chats/data/datasources/chats_remote_datasource.dart';
import 'package:maser/app/chats/data/repositories/chats_repository_impl.dart';
import 'package:maser/app/chats/domain/usecases/create_chat_group.dart'
    as createChatGroupUseCase;
import 'package:maser/app/chats/domain/usecases/get_chat_group.dart'
    as getChatGroupUseCase;
import 'package:maser/app/chats/presentation/viewmodels/chat_messaging_page_viewmodel.dart';
import 'package:maser/app/stories/data/datasources/stories_remote_datasource.dart';
import 'package:maser/app/stories/data/repositories/stories_repository_impl.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/domain/usecases/add_story_to_favorite.dart';
import 'package:maser/app/stories/domain/usecases/delete_story_from_favorite.dart'
    as delStoryFromFav;
import 'package:maser/app/stories/domain/usecases/get_fav_stories.dart';
import 'package:maser/app/stories/domain/usecases/get_liked_story.dart';
import 'package:maser/app/stories/domain/usecases/get_stories.dart';
import 'package:maser/app/stories/domain/usecases/like_story.dart' as likeStory;
import 'package:maser/app/stories/domain/usecases/undo_like_story.dart'
    as undoLikeStory;
import 'package:maser/app/stories/presentation/viewmodels/add_stories_viewmodel.dart';
import 'package:maser/core/enums/filter_stories.dart';
import 'package:maser/core/managers/navigation/route_constants.dart';
import 'package:maser/core/services/network/network_info.dart';
import 'package:maser/core/usecases/usecase.dart';

class StoriesPageViewmodel extends GetxController {
  var stories = <Story>[].obs;
  var favStoriesIds = <String>[].obs;
  var likedStoriesIds = <String>[].obs;
  var isFetchingStories = false.obs;
  var shownStories = <Story>[].obs;

  final userId = FirebaseAuth.instance.currentUser.uid;

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

  final _likeStory = likeStory.LikeStory(
    StoriesRepositoryImpl(
      remoteDatasource: StoriesRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  final _undoLikeStory = undoLikeStory.UndoLikeStory(
    StoriesRepositoryImpl(
      remoteDatasource: StoriesRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  final _getLikedStories = GetLikedStories(
    StoriesRepositoryImpl(
      remoteDatasource: StoriesRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  final _createChatGroup = createChatGroupUseCase.CreateChatGroup(
    ChatsRepositoryImpl(
      remoteDatasource: ChatsRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  final _getChatGroup = getChatGroupUseCase.GetChatGroup(
    ChatsRepositoryImpl(
      remoteDatasource: ChatsRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  Future<void> getStories({bool isInit = false}) async {
    if (isInit) isFetchingStories.value = true;
    stories.value = [];
    final result = await _getStories(NoParams());
    await fetchFavStories();
    await fetchLikedStories();

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

  Future<void> fetchLikedStories() async {
    likedStoriesIds.value = [];
    final result = await _getLikedStories(NoParams());
    if (result.isLeft()) {
      Get.showSnackbar(GetBar(
        message: 'Something went wrong',
      ));
    } else {
      likedStoriesIds.value = result.getOrElse(null);
    }
    return;
  }

  Future<void> addToLikedStories(String storyId) async {
    if (likedStoriesIds.contains(storyId)) {
      return;
    }
    likedStoriesIds.add(storyId);
    final story = stories.firstWhere((element) => element.id == storyId);
    final index = stories.indexOf(story);
    stories[index] = Story(
      id: story.id,
      storyTitle: story.storyTitle,
      storyContent: story.storyContent,
      imageUrl: story.imageUrl,
      postedOn: story.postedOn,
      mentorId: story.mentorId,
      likeCount: story.likeCount + 1,
    );
    final result = await _likeStory(likeStory.Params(storyId: storyId));
    if (result.isLeft()) {
      likedStoriesIds.remove(storyId);
      stories[index] = story;
      Get.showSnackbar(GetBar(
        message: 'Something went wrong',
      ));
    }
    return;
  }

  Future<void> removeFromLikedStories(String storyId) async {
    if (!likedStoriesIds.contains(storyId)) {
      return;
    }
    likedStoriesIds.remove(storyId);
    final story = stories.firstWhere((element) => element.id == storyId);
    final index = stories.indexOf(story);
    stories[index] = Story(
      id: story.id,
      storyTitle: story.storyTitle,
      storyContent: story.storyContent,
      imageUrl: story.imageUrl,
      postedOn: story.postedOn,
      mentorId: story.mentorId,
      likeCount: story.likeCount - 1,
    );
    final result = await _undoLikeStory(undoLikeStory.Params(storyId: storyId));
    if (result.isLeft()) {
      likedStoriesIds.add(storyId);
      stories[index] = story;
      Get.showSnackbar(GetBar(
        message: 'Something went wrong',
      ));
    }
    return;
  }

  void toggleLikeButton(String storyId) {
    if (likedStoriesIds.contains(storyId)) {
      removeFromLikedStories(storyId);
    } else {
      addToLikedStories(storyId);
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

  void navigateToStoryDetailsPage(Story _story) {
    Get.toNamed(RouteConstants.storyDetailsPage, arguments: _story);
  }

  Future<void> createChatGroupAndNavigate(String mentorId) async {
    Get.showSnackbar(GetBar(
      overlayBlur: 4,
      message: 'Please wait! Creating chat group...',
      duration: Duration(seconds: 2),
    ));
    final result = await _createChatGroup(
      createChatGroupUseCase.Params(mentorId: mentorId),
    );
    if (Get.isOverlaysOpen) {
      Get.back();
    }
    if (result.isLeft()) {
      Get.showSnackbar(GetBar(
        message: "Something went wrong!",
      ));
    } else {
      final result = await _getChatGroup(
        getChatGroupUseCase.Params(chatGroupId: mentorId),
      );
      if (result.isLeft()) {
        Get.showSnackbar(GetBar(
          message: "Something went wrong!",
          duration: Duration(seconds: 2),
        ));
      } else {
        final chatGroup = result.getOrElse(null);
        Get.put(ChatMessagingPageViewmodel(chatGroup));
        Get.toNamed(RouteConstants.chatMessagingPage).then((value) {
          Get.delete<ChatMessagingPageViewmodel>();
        });
      }
    }
  }
}
