import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/my_text_field.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/review_model.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:get/get.dart';


class WriteReviewScreen extends StatefulWidget {
  final int productId;

  const WriteReviewScreen({Key key, this.productId}) : super(key: key);
  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  @override
  void initState() {
    super.initState();
   //Get.find<ProductController>().getProductReviews(widget.lineItems.productId, formWriteReview:  true, userMail: Get.find<ProfileController>().profileModel.email);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<ProductController>().emptyFormData();
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'write_a_review_title'.tr,
          onBackPressed: (){
            Get.find<ProductController>().emptyFormData();
            Get.back();
          },
        ),
        body: GetBuilder<ProductController>(
          builder: (productController) {
            return !productController.isInitLoading ? Padding ( padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('write_a_review'.tr, style: DMSansMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        child: ListView.builder (
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding (
                              padding: EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL ),
                              child: InkWell(
                                child: (index <= productController.ratingIndex) ? Image.asset(Images.starYellow) : Image.asset(Images.starSilver),
                                onTap: () {
                                  productController.setRatingIndex(index);
                                },
                              ));
                          }),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                      Text('${productController.ratingIndex != -1 ? productController.ratingIndex+1 : 0}/5', style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.grey)),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                  Text('write_your_review'.tr, style: poppinsRegular.copyWith( fontSize: Dimensions.fontSizeDefault)),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                  SizedBox(
                    height: 200,
                    child: MyTextField(
                      controller: productController.reviewController,
                      maxLines: 8,
                      capitalization: TextCapitalization.sentences,
                      isEnabled: true,
                      hintText: 'write_your_review_here'.tr,
                      fillColor: Theme.of(context).disabledColor.withOpacity(0.05),
                      onChanged: (text) { },
                    ),
                  ),

                  Get.find<AuthController>().isLoggedIn() ? SizedBox() :
                  SizedBox(
                    child: MyTextField(
                      controller: productController.reviewerNameController,
                      maxLines: 1,
                      inputType: TextInputType.name,
                      isEnabled: true,
                      hintText: 'reviewer_name'.tr,
                      fillColor: Theme.of(context).disabledColor.withOpacity(0.05),
                      onChanged: (text) { },
                    ),
                  ),
                  Get.find<AuthController>().isLoggedIn() ? SizedBox() :SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                  Get.find<AuthController>().isLoggedIn() ? SizedBox() :
                  SizedBox(
                    child: MyTextField(
                      controller: productController.reviewerEmailController,
                      maxLines: 1,
                      isEnabled: true,
                      inputType: TextInputType.emailAddress,
                      hintText: 'reviewer_email'.tr,
                      fillColor: Theme.of(context).disabledColor.withOpacity(0.05),
                      onChanged: (text) { },
                    ),
                  ),
                  Get.find<AuthController>().isLoggedIn() ? SizedBox() :SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !productController.isLoading ?
                      CustomButton(
                        radius: Dimensions.RADIUS_LARGE,
                        width: MediaQuery.of(context).size.width-30,
                        buttonText: productController.isUpdate ? 'update_review'.tr : 'submit_review'.tr,
                        onPressed: () {
                          if(productController.ratingIndex == -1) {
                            showCustomSnackBar('give_a_rating'.tr);
                          } else if(productController.reviewController.text.isEmpty){
                            showCustomSnackBar('write_a_review'.tr);
                          } else if (!Get.find<AuthController>().isLoggedIn() && productController.reviewerNameController.text.isEmpty) {
                            showCustomSnackBar('enter_your_name'.tr);
                          } else if(!Get.find<AuthController>().isLoggedIn() && productController.reviewerEmailController.text.isEmpty) {
                            showCustomSnackBar('enter_email_address'.tr);
                          } else if (!Get.find<AuthController>().isLoggedIn() && !productController.reviewerEmailController.text.contains('@')) {
                            showCustomSnackBar('invalid_email_address'.tr);
                          } else if( !Get.find<AuthController>().isLoggedIn() && !GetUtils.isEmail(productController.reviewerEmailController.text) ) {
                            showCustomSnackBar('invalid_email_address'.tr);
                          }else{
                            SubmitReviewModel review = SubmitReviewModel(
                              productId: widget.productId,
                              review: productController.reviewController.text,
                              reviewer: Get.find<AuthController>().isLoggedIn() ? Get.find<ProfileController>().profileModel.firstName : productController.reviewerNameController.text,
                              reviewerEmail: Get.find<AuthController>().isLoggedIn() ? Get.find<ProfileController>().profileModel.email : productController.reviewerEmailController.text,
                              rating: productController.ratingIndex+1,
                            );
                            if(productController.isUpdate) {
                              productController.updateReview(review, productController.reviewId);
                            } else {
                              productController.submitReview(review);
                            }
                           // updateReview();
                          }
                        },
                      ) : Center(child: CircularProgressIndicator()),
                    ],
                  )
                ]),
              )),
            ) : Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }
}
