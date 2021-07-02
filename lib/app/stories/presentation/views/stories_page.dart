import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/presentation/viewmodels/stories_page_viewmodel.dart';
import 'package:maser/core/enums/filter_stories.dart';
import 'package:maser/core/managers/theme/app_colors.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class StoriesPage extends StatelessWidget {
  final model = Get.put(StoriesPageViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Stories',
        menu: _buildPopMenuButton(),
      ),
      body: Obx(
        () => model.isFetchingStories.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: model.getStories,
                color: AppColors.ruby,
                child: Obx(() {
                  if (model.shownStories.length <= 0) {
                    return Center(
                      child: TextButton.icon(
                        onPressed: model.getStories,
                        icon: Icon(Icons.refresh),
                        label: Text('No stories to show. Refresh!'),
                      ),
                    );
                  }
                  final _stories = model.shownStories;
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _stories.length,
                    itemBuilder: (_, i) => _buildStoryCard(_stories[i]),
                  );
                }),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            model.navigateToAddStoriesPage();
          },
        ),
      ),
    );
  }

  _buildPopMenuButton() {
    return PopupMenuButton<FilterStories>(
      color: AppColors.pastel_grey,
      onSelected: (val) {
        debugPrint(val.toString());
        model.storiesToShow(filter: val);
      },
      icon: Icon(
        Icons.menu,
        color: Colors.black,
      ),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('All'),
          value: FilterStories.all,
        ),
        PopupMenuItem(
          child: Text('Saved'),
          value: FilterStories.saved,
        ),
      ],
    );
  }

  _buildStoryCard(Story _story) {
    return Container(
      height: 300,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) => Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  height: constraints.maxHeight,
                  child: Image.network(
                    _story.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(
                      child: Icon(
                        Icons.image_rounded,
                        size: constraints.maxHeight * 0.5,
                        color: AppColors.grass,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => IconButton(
                              icon: Icon(
                                model.likedStoriesIds.contains(_story.id)
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_alt_outlined,
                              ),
                              onPressed: () =>
                                  model.toggleLikeButton(_story.id),
                            ),
                          ),
                          Text('|'),
                          Obx(
                            () => IconButton(
                              icon: Icon(
                                model.favStoriesIds.contains(_story.id)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                              ),
                              onPressed: () => model.toggleFavButton(_story.id),
                            ),
                          ),
                          Text('|'),
                          IconButton(
                            icon: Icon(Icons.chat_bubble_outline),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Positioned(
                        top: 2,
                        left: 25,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.sky_blue,
                          foregroundColor: Colors.white,
                          child: FittedBox(
                            child: Text(_story.likeCount.toString()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
