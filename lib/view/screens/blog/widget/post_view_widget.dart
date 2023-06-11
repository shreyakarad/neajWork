import 'package:flutter_woocommerce/view/screens/blog/all_posts_screen.dart';
import 'package:flutter_woocommerce/view/screens/blog/controller/blog_controller_dart.dart';
import 'package:flutter_woocommerce/view/screens/blog/model/blog_post_model.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/rating_bar.dart';
import 'package:flutter_woocommerce/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/blog/widget/post_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class PostView extends StatelessWidget {
  PostView();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlogController>(builder: (blogController) {
      ScrollController _scrollController = ScrollController();
      List<BlogPostModel> _blogList = blogController.blogPostList;
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: TitleWidget(
              title: 'our_blog_posts'.tr,
              onTap: () {
                Get.to(() => AllPostScreen());
              },
            ),
          ),

          SizedBox(
            height:120,
            child: _blogList != null ? ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
              itemCount: _blogList.length > 5 ? 5 : blogController.blogPostList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.fromLTRB(2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
                  child: InkWell(
                    onTap: () {
                      // Get.toNamed(
                      //  RouteHelper.getProductDetailsRoute(_blogList[index].id),
                      //   arguments: ProductDetailsScreen(product: blogPostList[index]),
                      // );
                    },
                    child: Container(
                      height: 70, width: 250,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        boxShadow: [BoxShadow(
                          color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                          blurRadius: 5, spreadRadius: 1,
                        )],
                      ),
                      child: PostWidget(post: _blogList[index])
                    ),
                  ),
                );
              },
            ) : PopularFoodShimmer(enabled: _blogList == null),
          ),
        ],
      );
    });
  }
}

class PopularFoodShimmer extends StatelessWidget {
  final bool enabled;
  PopularFoodShimmer({@required this.enabled});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          height: 80, width: 200,
          margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300], blurRadius: 10, spreadRadius: 1)],
          ),
          child: Shimmer(
            duration: Duration(seconds: 1),
            interval: Duration(seconds: 1),
            enabled: enabled,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Container(
                height: 70, width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 100, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: 5),

                    Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: 5),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(height: 10, width: 30, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                      RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                    ]),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}


