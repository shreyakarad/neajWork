import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/helper/date_converter.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:flutter_woocommerce/view/screens/order/model/order_model.dart';
import 'package:get/get.dart';

class OrderTrackingScreen extends StatefulWidget {
  final int orderId;
  final OrderModel order;
  OrderTrackingScreen({@required this.orderId, @required this.order});

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    if(widget.order == null) {
      Get.find<OrderController>().getOrderDetails(widget.orderId);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> _statusList = [AppConstants.PENDING, AppConstants.PROCESSING, AppConstants.ON_HOLD ];

    List<String> _messageList = [];

    return Scaffold(
      appBar: CustomAppBar(title: 'order_tracking'.tr),
      body: GetBuilder<OrderController>(builder: (orderController) {
        OrderModel _track;
        if(orderController.order != null) {
          _track = orderController.order;
        }

        if(_track != null) {
          _messageList.add(
            Get.find<ConfigController>().settings.activityMessages.pending == null ? '' :
            Get.find<ConfigController>().settings.activityMessages.pending.message,
          );
        }

        if(_track != null) {
          _messageList.add(
            Get.find<ConfigController>().settings.activityMessages.processing == null ? '' :
            Get.find<ConfigController>().settings.activityMessages.processing.message,
          );
        }

        if(_track != null) {
          _messageList.add(
            Get.find<ConfigController>().settings.activityMessages.onHold == null ? '' :
            Get.find<ConfigController>().settings.activityMessages.onHold.message,
          );
        }

        if ((_track != null) && Get.find<OrderController>().order.status == AppConstants.COMPLETED) {
          _statusList.add(AppConstants.COMPLETED);
          _messageList.add(
            Get.find<ConfigController>().settings.activityMessages.completed == null ? '' :
            Get.find<ConfigController>().settings.activityMessages.completed.message,
          );
        } else if ((_track != null) && Get.find<OrderController>().order.status == AppConstants.FAILED) {
          _statusList.add(AppConstants.FAILED);
          _messageList.add(
            Get.find<ConfigController>().settings.activityMessages.failed == null ? '' :
            Get.find<ConfigController>().settings.activityMessages.failed.message,
          );
        }else if ((_track != null) && Get.find<OrderController>().order.status == AppConstants.CANCELLED) {
          _statusList.add(AppConstants.CANCELLED);
          _messageList.add(
            Get.find<ConfigController>().settings.activityMessages.cancelled == null ? '' :
            Get.find<ConfigController>().settings.activityMessages.cancelled.message,
          );
        } else if (_track != null){
          _statusList.add(AppConstants.COMPLETED);
          _messageList.add(
            Get.find<ConfigController>().settings.activityMessages.completed == null ? '' :
            Get.find<ConfigController>().settings.activityMessages.completed.message,
          );
        }

        return _track != null ? SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(children: [
            Row(children: [
              Text('${'order_id'.tr}:', style: robotoRegular),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text('#${_track.id}', style: robotoMedium),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Expanded(child: SizedBox()),
              Icon(Icons.watch_later, size: 17),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(
                DateConverter.isoStringToLocalDateTime(_track.dateCreated),
                style: robotoRegular,
              ),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            ListView.builder(
              itemCount: _statusList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                int _step = -1;
                if(_track.status == AppConstants.PENDING) {
                  _step = 0;
                }else if(_track.status == AppConstants.PROCESSING) {
                  _step = 1;
                }if(_track.status == AppConstants.ON_HOLD) {
                  _step = 2;
                }if(_track.status == AppConstants.COMPLETED) {
                  _step = 3;
                }if(_track.status == AppConstants.CANCELLED) {
                  _step = 3;
                }if(_track.status == AppConstants.REFUNDED) {
                  _step = 3;
                }if(_track.status == AppConstants.FAILED) {
                  _step = 3;
                }
                Color _color = Colors.green.withOpacity(_step >= index ? 1 : 0.3);

                return Row(children: [

                  Column(children: [
                    SizedBox(
                      height: 40,
                      child: index != 0 ? VerticalDivider(width: 2, thickness: 2, color: _color) : SizedBox(),
                    ),
                    Icon(_step >= index ? Icons.check_circle : Icons.circle, color: _color),
                    SizedBox(
                      height: 40,
                      child: index != _statusList.length-1 ? VerticalDivider(width: 2, thickness: 2, color: Colors.green.withOpacity(_step > index ? 1 : 0.3)) : SizedBox(),
                    ),
                  ]),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(_statusList[index].tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text(_messageList[index].tr, style: robotoRegular),
                  ])),

                ]);
              },
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            widget.order == null ?
            CustomButton(buttonText: 'back_to_home'.tr,
              radius: 50,
              onPressed: () => Get.offAllNamed(RouteHelper.getInitialRoute())) : SizedBox(),

          ]))),
        ) : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
