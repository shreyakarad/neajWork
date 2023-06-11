import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/screens/blog/controller/blog_controller_dart.dart';
import 'package:flutter_woocommerce/view/screens/blog/widget/post_widget.dart';
import 'package:get/get.dart';

class AllPostScreen extends StatefulWidget {
  @override
  State<AllPostScreen> createState() => _AllPostScreenState();
}

class _AllPostScreenState extends State<AllPostScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'posts'.tr),
      body: RefreshIndicator(
        onRefresh: () async {
          await  Get.find<BlogController>().getBlogPosts(1);
        },
        child: Scrollbar(child: SingleChildScrollView(
            child: Center(child: SizedBox(
            width: Dimensions.WEB_MAX_WIDTH,
            child: GetBuilder<BlogController>(builder: (blogController) {
             return PaginatedListView(
              scrollController: _scrollController,
              perPage: 10,
              dataList: blogController.blogPostList,
              onPaginate: (int offset) async => await blogController.getBlogPosts(offset),
              itemView : ListView.builder(
                  itemCount: blogController.blogPostList.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                return Padding(
                  padding:  EdgeInsets.fromLTRB(2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
                  child: Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        boxShadow: [BoxShadow(
                          color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                          blurRadius: 5, spreadRadius: 1,
                        )],
                      ),
                      child: PostWidget(post: blogController.blogPostList[index], isAllPost:true)),
                );
                //  PostView(blogController.blogPostList[index]);
              })
            );
          }),
        )))),
      ),
    );
  }
}

