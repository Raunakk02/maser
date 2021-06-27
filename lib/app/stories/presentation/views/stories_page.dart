import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildStoryCard(),
            _buildStoryCard(),
            _buildStoryCard(),
          ],
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
    return PopupMenuButton(
      color: AppColors.pastel_grey,
      onSelected: (val) {
        debugPrint(val.toString());
        //TODO: use val
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

  _buildStoryCard() {
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
                //TODO: replace with image child
                child: Container(
                  height: constraints.maxHeight,
                  color: Colors.blue,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up_alt_outlined),
                        onPressed: () {},
                      ),
                      Text('|'),
                      IconButton(
                        icon: Icon(Icons.favorite_outline),
                        onPressed: () {},
                      ),
                      Text('|'),
                      IconButton(
                        icon: Icon(Icons.chat_bubble_outline),
                        onPressed: () {},
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
