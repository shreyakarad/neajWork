import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/notification/model/notification_model.dart';

import '../../../../util/dimensions.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationModel notificationModel;
  final String type;
  NotificationDialog({@required this.notificationModel, this.type});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child:  SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              ((notificationModel.image != '') && (type == 'feed' || type == 'offer')) ?
              Container(
                height: 150, width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Theme.of(context).primaryColor.withOpacity(0.20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  child: CustomImage(
                    image: notificationModel.image,
                    height: 150, width: MediaQuery.of(context).size.width, fit: BoxFit.fill,
                  ),
                ),
              ) : SizedBox(),
              ((notificationModel.image != '') && type == 'feed' || type == 'offer') ? SizedBox(height: Dimensions.PADDING_SIZE_SMALL) : SizedBox(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Text(
                  notificationModel.title,
                  textAlign: TextAlign.center,
                  style: poppinsMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Text(
                  notificationModel.description.replaceAll('\\', ''),
                  textAlign: TextAlign.justify,
                  style: robotoRegular.copyWith(
                    color: Theme.of(context).disabledColor,
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
