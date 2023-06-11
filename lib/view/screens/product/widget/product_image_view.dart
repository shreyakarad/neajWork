import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';

class ProductImageView extends StatelessWidget {
  final ProductModel product;
  ProductImageView({@required this.product});

  @override
  Widget build(BuildContext context) {
    List<String> _imageList = [];
    for(ImageModel image in product.images) {
      _imageList.add(image.src);
    }

    return Container(height: 300,
      child: GetBuilder<ProductController>(
        builder: (productController) {
          List<Widget> indicators = [];
          for (int index = 0; index < _imageList.length; index++) {
            indicators.add(TabPageSelectorIndicator(
              backgroundColor: index == productController.imageSliderIndex ? Theme.of(context).primaryColor : Colors.white,
              borderColor: Colors.white,
              size: 10,
            ));
          }

          return Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: ResponsiveHelper.isDesktop(context)? 350: MediaQuery.of(context).size.width * 0.7,
                  child: Hero(
                    tag: product.id.toString(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      child: CustomImage(
                        image: (_imageList != null &&_imageList.isNotEmpty) ? _imageList[productController.imageIndex ?? 0] : '',
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              SizedBox(width: 55, height: MediaQuery.of(context).size.width * 0.7,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: _imageList.length,
                    itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(3),
                    child: InkWell(
                      onTap: ()=> productController.setImageIndex(index, true),
                      child: Container( height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: index == productController.imageIndex? 2 : 0, color: Theme.of(context).primaryColor)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: CustomImage(
                          image: _imageList[index],
                          height: 50,
                          width: 50,
                      ),
                        ),),
                    ),
                  );
                }),
              )
            ],
          );
        },
      ),
    );
  }
}
