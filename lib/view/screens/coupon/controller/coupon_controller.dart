import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter_woocommerce/helper/date_converter.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/coupon_model.dart';
import 'package:flutter_woocommerce/view/screens/coupon/repository/coupon_repo.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:get/get.dart';

class CouponController extends GetxController implements GetxService {
  final CouponRepo couponRepo;
  CouponController({@required this.couponRepo});

  List<CouponModel> _couponList;
  CouponModel _coupon;
  double _discount = 0.0;
  double _discountAmount = 0.0;
  bool _isLoading = false;
  List<double> _itemDiscountList;

  CouponModel get coupon => _coupon;
  double get discount => _discount;
  bool get isLoading => _isLoading;
  List<CouponModel> get couponList => _couponList;
  String _selectedCouponCode;
  String get selectedCouponCode => _selectedCouponCode;
  List<double> get itemDiscountList => _itemDiscountList;

  Future<void> getCouponList(int offset, bool reload) async {
    if(reload || offset == 1) {
      _couponList = null;
      update();
    }
    //update();
    Response response = await couponRepo.getCouponList(offset);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _couponList = [];
      }
      response.body.forEach((coupon) {
        CouponModel _coupon = CouponModel.fromJson(coupon);
        //print(_coupon.usedBy.toString());
        //&& DateConverter.estimatedDate(DateTime.parse(_coupon.dateExpires)).compareTo(DateConverter.estimatedDate(DateTime.now())) > 0
       if( _coupon.dateExpires != null && DateTime.parse(_coupon.dateExpires).compareTo(DateTime.now()) > 0) {
         if(_coupon.minimumAmount != null && double.parse(_coupon.minimumAmount) > 0){
           if(AppConstants.vendorType != VendorType.singleVendor  && _coupon.discountType != 'fixed_cart'  && _coupon.code != '') {
             _couponList.add(_coupon);
           }else if (AppConstants.vendorType == VendorType.singleVendor) {
             _couponList.add(_coupon);
           }
         }
       } else if (_coupon.dateExpires == null) {
         if(_coupon.minimumAmount != null && double.parse(_coupon.minimumAmount) > 0){
           if(AppConstants.vendorType != VendorType.singleVendor && _coupon.discountType != 'fixed_cart' && _coupon.code != '') {
             _couponList.add(_coupon);
           }else if (AppConstants.vendorType == VendorType.singleVendor) {
             _couponList.add(_coupon);
           }
         }
       }
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<double> applyCoupon( String couponCode, double orderAmount, List<CartModel> cartList, double minimumShippingFee ) async {
    _isLoading = true;
    _discount = 0;
    update();
    Response response = await couponRepo.applyCoupon(couponCode);
    if (response.statusCode == 200 && response.body.isNotEmpty ) {
      _coupon = CouponModel.fromJson(response.body[0]);
      if( _coupon.usageLimit != null && _coupon.usageLimit > 0 &&  (_coupon.usageCount != null && _coupon.usageCount >0) && (_coupon.usageLimit == _coupon.usageCount)) {
        int totalLeft = _coupon.usageLimit - _coupon.usageCount;
        if(totalLeft == 0) {
          showCustomSnackBar('coupon_usage_limit_has_been_reached'.tr);
        }
      }else if ( response.statusCode == 200 && response.body.isNotEmpty ) {
        _coupon = CouponModel.fromJson(response.body[0]);

        if(_coupon.maximumAmount != null && _coupon.maximumAmount.isNotEmpty && double.parse(_coupon.maximumAmount) < orderAmount) {
          showCustomSnackBar('${'the_maximum_item_purchase_amount_for_this_coupon_is'.tr}'
              '${PriceConverter.convertPrice(_coupon.maximumAmount)} '
              '${'but_you_have'.tr} ${PriceConverter.convertPrice(orderAmount.toString())}' );

        } else  if (_coupon.minimumAmount != null && _coupon.minimumAmount.isNotEmpty && double.parse(_coupon.minimumAmount) < orderAmount) {
          if(
          (_coupon.dateExpires != null ? DateTime.now().isBefore(DateConverter.isoStringToLocalDate(_coupon.dateExpires)) : true)
              && (_coupon.usageLimit != null ? _coupon.usageLimit > _coupon.usageCount : true)
          ) {
            if (_coupon.discountType == 'percent') {
              _discountAmount = double.parse(_coupon.amount) * orderAmount / 100;
            }else {
              _discountAmount = double.parse(_coupon.amount);
            }
            if(_coupon.discountType == 'fixed_product') {
              _itemDiscountList = [];
              for (int i=0; i <cartList.length; i++) {
                double productCouponAmount;
                print(cartList[0].prices.price);
                if(double.parse(cartList[i].prices.price) < _discountAmount ) {
                  productCouponAmount = double.parse(cartList[i].prices.price);
                  _discount += productCouponAmount;
                  _itemDiscountList.add(productCouponAmount);
                } else {
                  productCouponAmount = (_discountAmount * cartList[i].quantity);
                  _discount += productCouponAmount;
                  _itemDiscountList.add(productCouponAmount);
                }
              }
            } else if (_coupon.discountType == 'percent') {
              _itemDiscountList = [];
              for(int i=0; i <cartList.length; i++) {
               double percentCouponAmount =  double.parse(_coupon.amount) * (double.parse(cartList[i].prices.price) * cartList[i].quantity) / 100;
               _discount += percentCouponAmount;
               _itemDiscountList.add(percentCouponAmount);
              }
            } else {
              _discount = _discountAmount;
            }
          }
          }else {
            print('CouponMinimumFee-->${_coupon.minimumAmount}');
            print(orderAmount);
            _discount = 0.0;
            showCustomSnackBar('this_coupon_is_not_valid_for_you'.tr);
            _coupon = null;
          }
        } else {
          _discount = 0.0;
          showCustomSnackBar('${'the_minimum_item_purchase_amount_for_this_coupon_is'.tr}'
              '${PriceConverter.convertPrice(_coupon.minimumAmount)} '
              '${'but_you_have'.tr} ${PriceConverter.convertPrice(orderAmount.toString())}');
      }
    } else {
      _discount = 0.0;
      if(response.statusCode == 200 && response.body.isEmpty) {
        showCustomSnackBar('invalid_coupon_code'.tr);
      }else {
        ApiChecker.checkApi(response);
      }
    }
    if((orderAmount - _discount) < minimumShippingFee) {
      Get.find<OrderController>().setShippingIndex(0);
    }

    _isLoading = false;
    update();
    return _discount;
  }



  void removeCouponData(bool notify) {
    _coupon = null;
    _isLoading = false;
    _discount = 0.0;
    _selectedCouponCode = '';
    _itemDiscountList = null;
    if(notify) {
      update();
    }
  }


  void setSelectedCoupon(String couponID){
    _selectedCouponCode = couponID;
    update();
  }

}