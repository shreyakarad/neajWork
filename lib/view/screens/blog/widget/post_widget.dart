import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/blog/model/blog_post_model.dart';
import 'package:flutter_woocommerce/view/screens/blog/post_details_screen.dart';
import 'package:get/get.dart';


class PostWidget extends StatelessWidget {
  final bool isAllPost;
  final BlogPostModel post;
  PostWidget({@required this.post, this.isAllPost=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() =>BlogDetail(post: post));
        // Get.toNamed(
        //  RouteHelper.getProductDetailsRoute(_blogList[index].id),
        //   arguments: ProductDetailsScreen(product: blogPostList[index]),
        // );
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              child: CustomImage(
                image: post.imageFeature,
                height: isAllPost ? 150 : 50,
                width:isAllPost? Get.width-22 :50,
                fit: BoxFit.cover,
              ),
            ),

            isAllPost ? SizedBox() :
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL, vertical:0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    post.title.rendered,
                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                    maxLines: 3, overflow: TextOverflow.ellipsis,
                  ),
                ]),
              ),
            ),
          ],
        ),

        isAllPost ? Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL, vertical:0),
          child: Text(
            post.title.rendered,
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
            maxLines: 2, overflow: TextOverflow.ellipsis,
          ),
        ) : SizedBox(),

        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        Text(post.content.rendered,
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
            maxLines: isAllPost? 5:2, overflow: TextOverflow.ellipsis
        ),
      ]),
    );
  }
}
