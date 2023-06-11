import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/base/paginated_list_view.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/notification/controller/notification_controller.dart';
import 'package:flutter_woocommerce/view/screens/notification/widgets/notification_dialog.dart';
import 'package:flutter_woocommerce/view/screens/notification/widgets/notification_widget.dart';
import 'package:flutter_woocommerce/view/screens/root/not_logged_in_screen.dart';
import 'package:get/get.dart';

class NotificationViewScreen extends StatefulWidget {
  final String form;
  final bool fromNotification;
  NotificationViewScreen({@required this.form, this.fromNotification});
  @override
  State<NotificationViewScreen> createState() => _NotificationViewScreenState();
}

class _NotificationViewScreenState extends State<NotificationViewScreen> {
  bool _isLoggedIn;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    print(widget.form);
    Get.find<NotificationController>().getNotificationList(1,false, widget.form);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.form.tr,
        onBackPressed: () {
          if(widget.fromNotification){
            Get.offAllNamed(RouteHelper.getInitialRoute());
          } else {
            Get.back();
          }
        }
      ),
      // notificationController.notificationList.length ==0 ?
      body: RefreshIndicator(
        onRefresh: () async {
          await  Get.find<NotificationController>().getNotificationList(1,true, widget.form);
        },
        child: GetBuilder<NotificationController>(
          builder: (notificationController) {
            return (widget.form == 'activity' && !_isLoggedIn) ? NotLoggedInScreen() : (!notificationController.isLoading && notificationController.notificationList.length == 0) ?
            NoDataScreen(text: 'no_notification_found'.tr, type: NoDataType.NOTIFICATION) :
            notificationController.notificationList.length != 0 ? SingleChildScrollView(
            controller: scrollController,
            child: Center(child: SizedBox(
                  width: Dimensions.WEB_MAX_WIDTH,
                  child: Column(
                      children: [
                        !notificationController.isLoading ?
                        SizedBox(
                          height: context.height-90,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: PaginatedListView(
                              perPage: 10,
                              scrollController: _scrollController,
                              dataList: notificationController.notificationList,
                              onPaginate: (int offset) async => Get.find<NotificationController>().getNotificationList(offset, false, widget.form),
                              itemView: ListView.builder(
                                  key: UniqueKey(),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: notificationController.notificationList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return NotificationWidget(
                                      title: notificationController.notificationList[index].title,
                                      description: notificationController.notificationList[index].description,
                                      dateTime: notificationController.notificationList[index].date,
                                      image: notificationController.notificationList[index].image,
                                      form: widget.form,
                                      id: notificationController.notificationList[index].id,
                                      onTap: () {
                                        showDialog(context: context, builder: (BuildContext context) {
                                          return NotificationDialog(notificationModel: notificationController.notificationList[index], type: widget.form);
                                        });
                                      },
                                    );
                                  }),
                            ),
                          ),
                        ):
                        //: NoDataScreen(text: 'no_notification_found'.tr, type: NoDataType.NOTIFICATION) :
                        Expanded(child: Center(child: CircularProgressIndicator())),
                      ],
                    ),
                ))) : _notificationWidget();
          }
        ),
      ),
    );
  }
  Widget _notificationWidget() {
    return  ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 12,
      itemBuilder: (context, index){
        return Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]
                ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container( height: 15, width: 200, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container( height: 12, width: 150, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container( height: 10, width: 150, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                  ],
                )
              )
            ],
          ),
        );

      },
    );
  }

}

















//   PaginatedListView(
//     scrollController: _scrollController,
//     perPage: 10,
//     dataList: blogController.blogPostList,
//     onPaginate: (int offset) async => await blogController.getBlogPosts(offset),
//     itemView :
//     ListView.builder(
//         itemCount: blogController.blogPostList.length,
//         shrinkWrap: true,
//         physics: ClampingScrollPhysics(),
//         itemBuilder: (context,index){
//           return Padding(
//             padding:  EdgeInsets.fromLTRB(2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
//             child: Container(
//                 padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                   boxShadow: [BoxShadow(
//                     color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
//                     blurRadius: 5, spreadRadius: 1,
//                   )],
//                 ),
//                 child: PostWidget(post: blogController.blogPostList[index], isAllPost:true)),
//           );
//           //  PostView(blogController.blogPostList[index]);
//         })
// );
