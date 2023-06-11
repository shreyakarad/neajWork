import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum DiscountType {
  amount,
  percent,
}

class PriceConverter {

  static String convertPrice(String price, {String taxStatus, String taxClass, bool fromCart = false}) {
    String _currencyPosition = Get.find<ConfigController>().getCurrencyPosition();
    String _expression = Get.find<ConfigController>().getCurrencyPosition();
    NumberFormat _numberFormat = NumberFormat.simpleCurrency(locale: Platform.localeName, name: Get.find<ConfigController>().getCurrency());
    double _price = price.isNotEmpty ? double.parse(price) : 0;
    if(Get.find<ConfigController>().calculateTax() && Get.find<ConfigController>().priceIncludeTax()
        && (fromCart ? Get.find<ConfigController>().displayCartPriceExcludeTax() : Get.find<ConfigController>().displayPriceExcludeTax())
        && taxStatus != null && taxStatus == 'taxable' && taxClass != null) {
      try{
        String _rate = Get.find<ConfigController>().taxClassList.firstWhere((tClass) => tClass.taxClass == taxClass).rate;
        if(_rate != null && _rate.isNotEmpty) {
          double _tax = _price - (_price / (( double.parse(_rate) / 100) + 1));
          _price -= _tax;
        }
      }catch(e) {}
    }
    return (_currencyPosition.contains('left') ? '${_numberFormat.currencySymbol}' : '')
        + (_currencyPosition == 'left_space' ? ' ' : '')
        + '${(_price).toStringAsFixed(Get.find<ConfigController>().digitAfterDecimal()).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))' + _expression), (Match m) => '${m[1]}${Get.find<ConfigController>().thousandSeparator()}')}'
        + (_currencyPosition == 'right_space' ? ' ' : '')
        + (_currencyPosition.contains('right') ? '${_numberFormat.currencySymbol}' : '');
  }

  static double convertWithDiscount(BuildContext context, double price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, DiscountType type, int quantity) {
    double calculatedAmount = 0;
    if(type == DiscountType.amount) {
      calculatedAmount = discount * quantity;
    }else if(type == DiscountType.percent) {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static double percentageCalculation(double price, double discount) {
    return (discount / price);
  }
}