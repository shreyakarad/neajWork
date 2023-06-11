import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/my_text_field.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/product/model/review_model.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class RatingReviewWidget extends StatefulWidget {
  final ProductModel product;
  const RatingReviewWidget({Key key, this.product}) : super(key: key);

  @override
  State<RatingReviewWidget> createState() => _RatingReviewWidgetState();
}

class _RatingReviewWidgetState extends State<RatingReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (productController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return InkWell(
                    child: Icon(
                      productController.rating < (i + 1) ? Icons.star_border : Icons.star,
                      size: 25,
                      color: productController.rating < (i + 1) ? Theme.of(context).disabledColor
                          : Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      productController.setRating( i + 1);
                    }
                  );
                },
              ),
            ),


            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            MyTextField(
              controller: productController.reviewController,
              maxLines: 3,
              capitalization: TextCapitalization.sentences,
              isEnabled: true,
              hintText: 'write_your_review_here'.tr,
              fillColor: Theme.of(context).disabledColor.withOpacity(0.05),
              onChanged: (text) { },
            ),
            SizedBox(height:  Dimensions.PADDING_SIZE_EXTRA_LARGE),

            productController.isLoading? Row(mainAxisAlignment: MainAxisAlignment.center,children: [CircularProgressIndicator()]):
            CustomButton(buttonText: 'submit_review'.tr,
              radius: 50,
              onPressed: (){
                if(productController.rating == 0){
                  showCustomSnackBar('give_a_rating'.tr);
                }else if(productController.reviewController.text.isEmpty){
                  showCustomSnackBar('write_a_review'.tr);
                } else{
                  SubmitReviewModel review = SubmitReviewModel(
                    productId: widget.product.id,
                    review: productController.reviewController.text,
                    reviewer: Get.find<ProfileController>().profileModel.firstName,
                    reviewerEmail: Get.find<ProfileController>().profileModel.email,
                    rating: productController.rating,
                  );
                  productController.submitReview(review);
                }
              },
            ),
            SizedBox(height:  Dimensions.PADDING_SIZE_EXTRA_LARGE),

          ],
        );
      }
    );
  }
}
