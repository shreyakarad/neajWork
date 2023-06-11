import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/date_converter.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:get/get.dart';

class NotificationWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String dateTime;
  final int unSeenCount;
  final Function onTap;
  final String form;
  final int id;
  const NotificationWidget({Key key, this.image, this.title, this.unSeenCount, this.onTap, this.description, this.dateTime, this.form, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(image);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all( Get.isDarkMode ? Dimensions.PADDING_SIZE_EXTRA_SMALL  : Dimensions.PADDING_SIZE_DEFAULT),
        child: Container(
          padding: EdgeInsets.all( Get.isDarkMode ? Dimensions.PADDING_SIZE_DEFAULT  : 0.0),
          color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.transparent,
          child: Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ((image != '') && (form == 'feed' || form == 'offer'))  ?
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                child: CustomImage(
                  image: image,
                  height: 48, width: 48,
                ),
              ):
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(form == 'activity' ? Images.my_activity : form == 'offer' ? Images.offer :  Images.feed, height: 24, width: 24)
                ],
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Text(
                      description,
                        maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:  Get.isDarkMode ?  null : Theme.of(context).primaryColor.withOpacity(0.50)),
                      textAlign: TextAlign.justify
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Text(
                      DateConverter.estimatedDateTime(DateTime.parse(dateTime)).toString(),
                      //DateTime.parse(dateTime).toString(),
                      style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),

                    // Text(
                    //   id.toString(),
                    //   style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    // ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


}

