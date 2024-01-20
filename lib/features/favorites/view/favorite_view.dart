import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/favorites/controller.dart/favorite_controller.dart';
import 'package:music_stream/utils/logic/database/database_manager.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:music_stream/utils/ui/shared_widgets/shared_widgets.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteC = Get.find<FavoriteController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        actions: [
          // FloatingActionButton.small(onPressed: () {
          //   favoriteC.playAll();
          // })
          GestureDetector(
            onTap: favoriteC.playAll,
            child: Container(
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Play',
                style: context.textTheme.titleMedium,
              ),
              decoration: ShapeDecoration(
                // color: AppColors.kRed,
                shape: StadiumBorder(
                  side: BorderSide(color: context.theme.iconTheme.color!),
                ),
              ),
              // width: 30,
              // height: 20,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          favoriteC.getAllFavoriteTableData();
        },
        color: AppColors.kBlack,
        backgroundColor: AppColors.kWhite,
        strokeWidth: 4.0,
        child: Obx(
          () => Padding(
            padding: AppSpacing.gapPSH16,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: favoriteC.variables.favoriteModelList.length,
                    itemBuilder: (_, i) {
                      final uniqueKey = UniqueKey();
                      final favoriteSongData =
                          favoriteC.variables.favoriteModelList[i];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 32),
                            child: Icon(Icons.delete_rounded),
                          ),
                        ),
                        key: uniqueKey,
                        onDismissed: (direction) {
                          DatabaseManager.deleteFromFavorite(
                              id: favoriteSongData.videoId);
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ImageLoaderWidget(
                            imageUrl: favoriteSongData.videoThumbnail,
                            width: 48.w,
                            height: 48.w,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(6).r,
                          ),
                          title: Text(
                            favoriteSongData.videoTitle,
                            // style: AppTypography.kSemiBold14,
                            style: context.textTheme.titleSmall,
                          ),
                          onTap: () {
                            favoriteC.playAll(index: i);
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (AudioHelper.playlistList.isNotEmpty) ...[AppSpacing.gapH100]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
