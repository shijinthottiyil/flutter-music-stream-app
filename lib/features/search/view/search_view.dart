import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';

import 'package:music_stream/features/search/view/search_play.dart';
import 'package:music_stream/features/search/view/search_song.dart';
import 'package:music_stream/features/search/view/widgets/search_textfield.dart';

import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/utils/constants/constants.dart';

import 'package:music_stream/utils/general_widgets.dart/bg.dart';

// class SearchView extends StatelessWidget {
//   SearchView({super.key});
//   final _controller = Get.put(SearchCtr());
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: exitApp,
//       child: Scaffold(
//           body: Padding(
//         padding: EdgeInsets.only(
//           top: 54.h,
//           left: 8.w,
//           right: 8.w,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Search", style: AppTypography.kSemiBold32),
//             AppSpacing.gapH12,
//             CupertinoTextField.borderless(
//               prefix: Padding(
//                 padding: const EdgeInsets.only(left: 10).w,
//                 child: const Icon(
//                   Icons.search,
//                   color: AppColors.kBrown75,
//                 ),
//               ),
//               placeholder: "Enter a song name",
//               placeholderStyle:
//                   AppTypography.kMedium18.copyWith(color: AppColors.kWhite),
//               style: AppTypography.kMedium18.copyWith(color: AppColors.kWhite),
//               decoration: BoxDecoration(
//                 color: AppColors.kBrown400,
//                 borderRadius: BorderRadius.circular(15).r,
//               ),
//               onSubmitted: (keyword) {
//                 _controller.getSearch(keyword);
//               },
//             ),
//             Obx(
//               () => Expanded(
//                 child: ListView.builder(
//                   itemBuilder: (context, index) {
//                     var data = _controller.search.searchList[index];
//                     return ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(6).r,
//                         child: FadeInImage(
//                           placeholder: AssetImage(
//                             AppAssets.kTileLead,
//                           ),
//                           image: NetworkImage(
//                             data.thumbnails!.last.url!,
//                           ),
//                           width: 48.w,
//                           height: 48.w,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(
//                         data.title ?? "Name",
//                         style: AppTypography.kSemiBold14,
//                       ),
//                       subtitle: Text(
//                         data.artists?[0].name ?? "subtitle",
//                         style: AppTypography.kRegular13,
//                       ),
//                       onTap: () {
//                         Get.find<HomeController>()
//                             .listTileTap(index: index, isHome: false);
//                       },
//                     );
//                   },
//                   itemCount: _controller.search.searchList.length,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  ///Controllers.
  ///
  var c = Get.put(SearchCtr());

  TabBar get _tabBar => TabBar(
        indicatorColor: Colors.red,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff1a73e8),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(icon: Icon(Icons.search_rounded)),
          Tab(icon: Icon(Icons.queue_music_rounded)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async {
          if (pc.isPanelOpen) {
            pc.close();
          } else {
            Get.find<BottomController>().bottom.selectedIndex.value = 0;
          }

          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            // titleSpacing: 14.r,
            // bottom: PreferredSize(
            //   preferredSize: _tabBar.preferredSize,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 15.w),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.grey.shade200,
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       child: _tabBar,
            //     ),
            //   ),
            // ),
            // title: SearchTextField(
            //   placeholder: 'എന്താ വേണ്ടേ? ',
            //   onSubmitted: (keyWord) {
            //     c.getSearch(keyWord);
            //   },
            // ),
            title: const Text(
              'Search',
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SearchTextField(
                  // suffix: IconButton(
                  //   // onPressed: () {
                  //   //   Get.find<SearchCtr>().voiceSearchTap();
                  //   // },
                  //   onPressed: _speechToText.isNotListening
                  //       ? _startListening
                  //       : _stopListening,
                  //   icon: Icon(_speechToText.isNotListening
                  //       ? Icons.mic_off_rounded
                  //       : Icons.mic_rounded),
                  // ),
                  onTap: c.voiceSearchTap,

                  placeholder: 'എന്താ വേണ്ടേ? ',
                  onSubmitted: (keyWord) {
                    c.getSearch(keyWord);
                  },
                ),
              ),
              AppSpacing.gapH8,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _tabBar,
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    SearchSong(),
                    SearchPlay(),
                  ],
                ),
              ),

              // BackdropFilter(
              //   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //   child: Dialog(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20.r)),
              //     backgroundColor: Colors.transparent,
              //     child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20.r)),
              //       width: 300,
              //       height: 300,
              //       child: Column(
              //         // mainAxisSize: MainAxisSize.min,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           AvatarGlow(
              //             glowRadiusFactor: 0.7,
              //             animate: isListening,
              //             glowColor: AppColors.kRed,
              //             child: GestureDetector(
              //               onTap: () {},
              //               child: Icon(
              //                 Icons.mic_rounded,
              //                 color: AppColors.kBlack,
              //                 size: 75.sp,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
