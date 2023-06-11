import 'package:flutter_woocommerce/helper/date_converter.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/model/review_model.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  final bool hasDivider;
  ReviewWidget({@required this.review, @required this.hasDivider});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Row(children: [
        CircleAvatar(
          radius: 15, child: Text(review.rating.toString(), style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

        Expanded(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

          Text(review.name ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
          ),

          Row(children: [
            RatingBar(rating: review.rating.toDouble(), ratingCount: null, size: 15),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            SizedBox(height: 15, child: VerticalDivider(thickness: 2)),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Text(
              DateConverter.isoStringToLocalDateOnly(review.dateCreated), maxLines: 1, overflow: TextOverflow.ellipsis,
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
            ),
          ]),

        ])),

      ]),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

      Text(review.review ?? '', style: poppinsRegular.copyWith(color: Theme.of(context).hintColor), textAlign: TextAlign.justify,),

      (hasDivider && ResponsiveHelper.isMobile(context)) ? Padding(
        padding: EdgeInsets.only(left: 0),
        child: Divider(color: Theme.of(context).disabledColor),
      ) : SizedBox(),

    ]);
  }
}
