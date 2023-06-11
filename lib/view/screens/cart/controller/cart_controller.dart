import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/helper/price_converter.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/country.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/state.dart' as st;
import 'package:flutter_woocommerce/view/screens/checkout/model/shipping_method_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/shipping_zones_model.dart';
import 'package:flutter_woocommerce/view/screens/checkout/model/tax_model.dart';
import 'package:flutter_woocommerce/view/screens/coupon/controller/coupon_controller.dart';
import 'package:flutter_woocommerce/view/screens/order/controller/order_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/cart/repository/cart_repo.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/screens/profile/controller/profile_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/profile_model.dart';
import 'package:get/get.dart';

import '../../profile/model/address_model.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;

  CartController({@required this.cartRepo});

  List<CartModel> _cartList;
  List<CartModel> _guestCartList;
  List<CartModelAll> _allCartList;
  Country _selectedCountry;
  st.State _selectedState;
  List<Country> _countrylist;
  List<st.State> _statelist;
  List<st.State> dropdownStateList = [];
  List<TaxModel> taxRateList = [];
  TaxModel _matchedTaxRate;
  ShippingZonesModel _shippingZone;
  int _cartIndex = -1;
  bool _isLoading = false;
  double _shippingFee = 0;
  double _productPrice = 0;
  List<double> _productPriceList = [];
  double _discount = 0;
  List<double> _discountList = [];
  double _tax = 0;
  double _shippingTax = 0;
  double _shippingClassFee = 0;


  ShippingZonesModel get shippingZone => _shippingZone;

  TaxModel get matchedTaxRate => _matchedTaxRate;

  List<st.State> get statelist => _statelist;

  List<Country> get countrylist => _countrylist;

  st.State get selectedState => _selectedState;

  Country get selectedCountry => _selectedCountry;

  List<CartModel> get cartList => _cartList;

  bool get isLoading => _isLoading;

  List<CartModelAll> get allCartList => _allCartList;

  double get shippingFee => _shippingFee;
  double get tax => _tax;
  double get shippingClassFee => _shippingClassFee;
  double get productPrice => _productPrice;
  double get discount => _discount;


  Future<void> getCartList({bool notify = false}) async {
    int userId = Get.find<AuthController>().isLoggedIn() ? Get.find<
        AuthController>().getSavedUserId() : 0;
    _allCartList = [];
    _guestCartList = [];
    _cartIndex = -1;
    _allCartList = cartRepo.getLocalCartList();
    List<CartModel> _tempCartList = [];
    for (int i = 0; i < _allCartList.length; i++) {
      if (_allCartList[i].id == userId) {
        _tempCartList = _allCartList[i].cartList;
        _cartIndex = i;
        break;
      }
    }

    if (userId != 0) {
      for (int i = 0; i < _allCartList.length; i++) {
        if (_allCartList[i].id == 0) {
          _guestCartList = _allCartList[i].cartList;
          _allCartList[i].cartList = [];
          break;
        }
      }
      for (int i = 0; i < _guestCartList.length; i++) {
        if (!_tempCartList.contains(_guestCartList[i])) {
          _tempCartList.add(_guestCartList[i]);
        }
      }
    }

    _cartList = [];
    for (CartModel cart in _tempCartList) {
      CartModel _cart = cart;
      try {
        if (_cart.product.taxClass.isNotEmpty) {
          _cart.tax = Get
              .find<ConfigController>()
              .taxClassList
              .firstWhere((tax) => tax.taxClass == _cart.product.taxClass);
        }
      } catch (e) {}
      print(_cart.variationText);
      _cartList.add(_cart);
    }

    if (userId != 0 && _guestCartList.length != 0) {
      addToCartFromGuest();
    }
    if (notify) {
      update();
    }
  }

  void addToCartFromGuest() async {
    int userId = Get.find<AuthController>().isLoggedIn() ? Get.find<
        AuthController>().getSavedUserId() : 0;

    if ((_cartIndex == -1) && _cartList.isNotEmpty || _allCartList.isNotEmpty) {
      _allCartList.add(
          CartModelAll(
            id: userId,
            cartList: _cartList,
          )
      );
    } else {
      _allCartList[_cartIndex].cartList = _cartList;
    }
    cartRepo.addToLocalCart(_allCartList);
    getCartList();
    update();
  }


  void addToCart(CartModel cartModel, int index) async {
    int userId = Get.find<AuthController>().isLoggedIn() ? Get.find<
        AuthController>().getSavedUserId() : 0;
    for (int i = 0; i < _allCartList.length; i++) {
      print('-----CartUserId------>${_allCartList[i].id}');
    }

    if ((_cartIndex == -1) && _cartList.isEmpty || _allCartList.isEmpty) {
      _cartList.add(cartModel);
      _allCartList.add(
          CartModelAll(
            id: userId,
            cartList: _cartList,
          )
      );
    } else {
      if (index != null && index != -1) {
        _cartList.replaceRange(index, index + 1, [cartModel]);
      } else {
        _cartList.add(cartModel);
      }
      _allCartList[_cartIndex].cartList = _cartList;
    }
    cartRepo.addToLocalCart(_allCartList);
    showCustomSnackBar('product_added_to_cart'.tr, isCart: true);
    getCartList();
    update();
    if (Get
        .find<ProductController>()
        .product != null) {
      Get.find<ProductController>().setExistInCart(Get
          .find<ProductController>()
          .product, notify: true);
    }
  }


  Future<void> setQuantity(bool isIncrement, int index, int stock, {bool fromBottomSheet = false}) async {
    if (isIncrement && (stock != null && _cartList[index].quantity >= stock)) {
      showCustomSnackBar('out_of_stock'.tr);
      if (fromBottomSheet) {
        Get.back();
      }
    } else {
      Get.find<CouponController>().removeCouponData(false);
      if (isIncrement) {
        _cartList[index].quantity = _cartList[index].quantity + 1;
      } else {
        _cartList[index].quantity = _cartList[index].quantity - 1;
      }
      _allCartList[_cartIndex].cartList = _cartList;
      cartRepo.addToLocalCart(_allCartList);
      Get.find<ProductController>().setExistInCart( Get.find<ProductController>().product, notify: true );
      update();
    }
  }

  Future<void> removeFromCart(int index) async {
    Get.find<CouponController>().removeCouponData(false);
    _cartList.removeAt(index);
    _allCartList[_cartIndex].cartList = _cartList;
    cartRepo.addToLocalCart(_allCartList);
    update();
    if (Get
        .find<ProductController>()
        .product != null) {
      Get.find<ProductController>().setExistInCart(Get
          .find<ProductController>()
          .product, notify: true);
    }
  }

  void clearCartList() async {
    _cartList = [];
    _allCartList[_cartIndex].cartList = _cartList;
    cartRepo.addToLocalCart(_allCartList);
    if (Get
        .find<ProductController>()
        .product != null) {
      Get.find<ProductController>().setExistInCart(Get
          .find<ProductController>()
          .product, notify: true);
    }
    update();
  }


  int isExistInCart(int productID, List<int> variationIds, String variationType,
      bool isUpdate, int cartIndex) {
    for (int index = 0; index < _cartList.length; index++) {
      if ((productID == _cartList[index].id ||
          variationIds.contains(_cartList[index].id)) &&
          (_cartList[index].variation.length > 0 ? _cartList[index]
              .variationText == variationType : true)) {
        if ((isUpdate && index == cartIndex)) {
          return -1;
        } else {
          return index;
        }
      }
    }
    return -1;
  }

  int getCartIndex(ProductModel product) {
    for (int index = 0; index < _cartList.length; index ++) {
      if (_cartList[index].id == product.id) {
        return index;
      }
    }
    return null;
  }


  initList() async {
    _countrylist = await loadCountries();
    _statelist = await loadState();
  }

  // void setDefaultCountry () {
  //   if(Get.find<ConfigController>().getDefaultCountry() != null){
  //     for(Country country in countrylist) {
  //       if(Get.find<ConfigController>().getDefaultCountry() == country.isoCode) {
  //         setSelectedCountry(country);
  //   }}}
  // }


  Future<List<Country>> loadCountries() async {
    final res = await rootBundle.loadString(
        'assets/country_state/country.json');
    final data = jsonDecode(res) as List;
    return List<Country>.from(data.map((item) => Country.fromJson(item)),
    );
  }

  Future<List<st.State>> loadState() async {
    final res = await rootBundle.loadString('assets/country_state/state.json');
    final data = jsonDecode(res) as List;
    return List<st.State>.from(data.map((item) => st.State.fromJson(item)));
  }

  getDropdownStateList() {
    dropdownStateList = [];
    statelist.forEach((element) {
      if (_selectedCountry.isoCode == element.countryCode)
        dropdownStateList.add(element);
    });
  }


  setSelectedCountry(Country country) {
    Get.find<OrderController>().emptyShippingMethodList();
    _selectedState = null;
    _matchedTaxRate = null;
    _selectedCountry = country;
    getDropdownStateList();
    update();
  }

  setSelectedState(st.State state) {
    Get.find<OrderController>().emptyShippingMethodList();
    _selectedState = state;
    print(state.isoCode);
    print(state.name);
    print(state.toJson());
    getShippingMethod();
    update();
    print("Selected State");
  }

  Future<void> getShippingMethod() async {
    _isLoading = true;
    update();
    for(ShippingZonesModel shippingZone in Get.find<OrderController>().shippingZonesList){
      if(Get.find<OrderController>().shippingMethodList != null) {
        Get.find<OrderController>().emptyShippingMethodList();
      }
      if (Get.find<LocationController>().profileShippingSelected ) {
        if(shippingZone.name == Get.find<ProfileController>().profileShippingAddress.stateIso){
          await Get.find<OrderController>().getShippingMethods(shippingZone.id);
          break;
        }
      } else if(Get.find<LocationController>().addressList.isNotEmpty && Get.find<LocationController>().selectedShippingAddressIndex != -1 && Get.find<LocationController>().addressList[Get.find<LocationController>().selectedShippingAddressIndex].state != null){
        if( shippingZone.name == Get.find<LocationController>().addressList[Get.find<LocationController>().selectedShippingAddressIndex].state.isoCode) {
          print('Shipping Zone list');
          print(shippingZone.id);
          await Get.find<OrderController>().getShippingMethods(shippingZone.id);
          break;
        }
      } else {
        if(Get.find<LocationController>().addressList.isNotEmpty && Get.find<LocationController>().selectedShippingAddressIndex != -1 && shippingZone.name == Get.find<LocationController>().addressList[Get.find<LocationController>().selectedShippingAddressIndex].country.isoCode) {
          print('Shipping Zone list');
          print(shippingZone.id);
          await Get.find<OrderController>().getShippingMethods(shippingZone.id);
          break;
        }
      }
    }
    _isLoading = false;
    update();
  }

  void calculateProductPrice( List<CartModel> _cartList ) {
    _discount = 0;
    _productPrice = 0;
    _productPriceList = [];
    _discountList = [];
    for (int i = 0; i < _cartList.length; i++) {
      CartModel cartModel = _cartList[i];
      double _itemPrice = 0;
      double _dis = 0;

      if(cartModel.prices.regularPrice.isNotEmpty) {
        _itemPrice = double.parse(cartModel.prices.regularPrice) * cartModel.quantity;
        _dis = (double.parse(cartModel.prices.regularPrice) - double.parse(cartModel.prices.price)) * cartModel.quantity;
      }else {
        _itemPrice = double.parse(cartModel.prices.price) * cartModel.quantity;
      }
      if(cartModel.prices.currencyMinorUnit != null) {
        for(int index=0; index<cartModel.prices.currencyMinorUnit; index++) {
          _itemPrice /= 10;
        }
      }

      _discount += _dis;
      _productPrice += _itemPrice;
      _productPriceList.add(_itemPrice);
      _discountList.add(_dis);
    }
  }



  double calculateShippingFee(List<CartModel> _cartList, ShippingMethodModel shippingMethod) {
    _shippingClassFee = 0;
    double _mainShipping = 0;
    _mainShipping = shippingMethod != null ? shippingMethod.total : 0;
    double _classShippingFee = classShippingFee(_cartList, shippingMethod);
    _shippingFee = _mainShipping + _classShippingFee;
    return _shippingFee;
  }

  double classShippingFee(List<CartModel> _cartList, ShippingMethodModel shippingMethod) {
    List<int> _shippingClassIds = [];
    if (shippingMethod != null) {
      for (int i = 0; i < _cartList.length; i++) {
        if (!_shippingClassIds.contains(_cartList[i].product.shippingClassId)) {
          if (_cartList[i].product.shippingClassId != 0 &&
              shippingMethod.methodId == 'flat_rate') {
            double _classFee = shippingMethod.data['settings']['class_cost_${_cartList[i].product.shippingClassId}']['value'] != '' ? double.parse(shippingMethod.data['settings']['class_cost_${_cartList[i].product.shippingClassId}']['value']) : 0;
            _shippingClassFee += _classFee;
            _shippingClassIds.add(_cartList[i].product.shippingClassId);
          }
        }
      }
    }
    return _shippingClassFee;
  }


  double calculateTax ( List<CartModel> _cartList, List<TaxModel> _taxClassList, List<double> _itemDiscountList, AddressModel shippingAddress, ProfileAddressModel _profileAddress, bool isProfileAddress) {
    _tax = 0;
    for (int index = 0; index < _cartList.length; index++) {
      if (_cartList[index].product.taxStatus == 'taxable') {
        String _productTaxClass;
        double _taxRate = 0;

        if (_cartList[index].product.taxClass == '') {
          _productTaxClass = 'standard';
        } else {
          _productTaxClass = _cartList[index].product.taxClass;
        }

        _taxClassList.forEach((taxRate) {
          String _taxClass = taxRate.taxClass.toLowerCase();
          if ( _taxClass == _productTaxClass) {
            bool _matchedAddress  = matchedAddress(taxRate, shippingAddress, _profileAddress, isProfileAddress);
            if(_matchedAddress){
              _taxRate = double.parse( taxRate.rate );
              try{
                _tax += PriceConverter.calculation((_productPriceList[index] - _discountList[index]) - (_itemDiscountList != null ? _itemDiscountList[index] : 0),
                    _taxRate, DiscountType.percent, 1
                );
              } catch(e) {}
            }
            }
          });
        }
      }
      return _tax;
  }

  double calculateShippingTax( List<CartModel> _cartList, List<TaxModel> _taxClassList, double _taxAmount, AddressModel shippingAddress, ProfileAddressModel _profileAddress, bool isProfileAddress, ) {
    double _shippingTaxRate = 0;
    _shippingTax = 0;
    for(int i =0; i<_taxClassList.length; i++) {
      bool _matchedAddress  = matchedAddress(_taxClassList[i], shippingAddress, _profileAddress, isProfileAddress);
      if(_matchedAddress) {
        for (int j = 0; j < _cartList.length; j++) {
          if (_cartList[j].product.taxStatus == 'taxable' || _cartList[j].product.taxStatus == 'shipping') {

            String _productTaxClass;
            if (_cartList[j].product.taxClass == '') {
              _productTaxClass = 'standard';
            } else {
              _productTaxClass = _cartList[j].product.taxClass;
            }

            String _taxClass = _taxClassList[i].taxClass.toLowerCase();
            if(_taxClassList[i].shipping){
              if ( _taxClass == _productTaxClass) {
                _shippingTaxRate =  double.parse(_taxClassList[i].rate);
                break;
              }
            }

          }
        }
      }
      if(_shippingTaxRate !=  0) {
        break;
      }
    }

    _shippingTax += PriceConverter.calculation (
      _shippingFee,
      _shippingTaxRate,
      DiscountType.percent,
      1,
    );

    return _shippingTax;
  }


  bool matchedAddress( TaxModel taxRate, AddressModel shippingAddress, ProfileAddressModel profileAddress, bool isProfileAddress) {
    bool _state = true;
    bool _addressMatched = false;

    print('metchAddress-->$shippingAddress');
    if(taxRate.state != ''){
      _state = taxRate.state ==  (isProfileAddress ? profileAddress != null ? profileAddress.stateIso : '' : shippingAddress != null ? shippingAddress.state.isoCode : '');
    }

    if (isProfileAddress) {
      if(taxRate.country == profileAddress.country && taxRate.postcode == profileAddress.postcode && taxRate.city.toLowerCase() == profileAddress.city.toLowerCase() && _state == true) {
        _addressMatched = true;
      }
    } else if(shippingAddress != null) {
      if(taxRate.country == shippingAddress.country.isoCode && taxRate.postcode == shippingAddress.postcode && taxRate.city.toLowerCase() == shippingAddress.city.toLowerCase() && _state == true) {
        _addressMatched = true;
      }
    }
    return _addressMatched;
  }







  }
