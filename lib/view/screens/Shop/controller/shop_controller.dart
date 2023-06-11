import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/screens/Shop/model/shop_model.dart';
import 'package:flutter_woocommerce/view/screens/Shop/repository/shop_repo.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:get/get.dart';

class ShopController extends GetxController implements GetxService{
  ShopRepo shopRepo;
  ShopController({@required this.shopRepo});

  List<ShopModel> _shopList;
  List<ShopModel> get shopList => _shopList;

  List<ProductModel> _dokanProductList;
  List<ProductModel> get dokanProductList => _dokanProductList;

  List<ProductModel> _searchProductList;
  List<ProductModel> get searchProductList => _searchProductList;

  String _searchText = '';
  String get searchText => _searchText;

  int shopCount;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  void searchedListEmpty(){
    _searchProductList =[];
    update();
  }


  Future<void> getShopList(int offset) async {
    if (offset == 1) {
     _shopList = null;
     shopCount = 0;
    }
    update();
    Response response = await shopRepo.getShopList(offset);
    if (response.body != null && response.statusCode == 200) {
      if (offset == 1) {
        _shopList = [];
      }
      response.body.forEach((shopItem) {
        shopCount += 1;
        if(AppConstants.vendorType != VendorType.dokan) {
          ShopModel shop =  ShopModel.fromJson(shopItem);
          _shopList.add(shop);
        }else if (AppConstants.vendorType == VendorType.dokan) {
          ShopModel shop =  ShopModel.fromJson(shopItem);
          if( shop.id ==1 ) {
            shop.gravatar = Images.logo_light;
            shop.storeName = AppConstants.DOKAN_ADMIN_STORE_NAME;
            shop.email = Get.find<ConfigController>().settings.businessSettings.email != '' ? Get.find<ConfigController>().settings.businessSettings.email : '';
            shop.address = Get.find<ConfigController>().settings.businessSettings.address != '' ? Get.find<ConfigController>().settings.businessSettings.address : '';
            shop.phone = Get.find<ConfigController>().settings.businessSettings.phone != '' ? Get.find<ConfigController>().settings.businessSettings.phone : '';
            _shopList.add((shop));
          } else if(shop.enabled){
            _shopList.add(shop);
          }
        }
      });
      update();
    }
  }



  Future<void> getShopProduct(int shopID, int offset, {bool notify = false}) async {
    if(offset == 1){
      _dokanProductList = null;
      _isSearching = true;
      if(notify) {
        update();
      }
    }
    Response response = await shopRepo.getShopProductsList(shopID, offset);
    if (response.statusCode == 200) {
      if(offset == 1){
        _dokanProductList = [];
        update();
      }
      response.body.forEach((product) async {
        ProductModel _product =  ProductModel.fromJson(product);
        if(_product.status == 'publish' && _product.type != 'grouped') {
          _dokanProductList.add(_product);
        }
      });
    }
    update();
  }

  void initSearchData() {
    //_restaurantSearchProductModel = ProductModel(products: []);
    _isSearching = false;
    _searchText = '';
  }


  Future<void> getStoreSearchItemList(String searchText, int storeID, int offset) async {
    if(offset == 1) {
      _searchProductList = null;
      _isSearching = true;
    }
    update();
    if(searchText.isEmpty) {
      showCustomSnackBar('write_item_name'.tr);
    }else {
      _searchText = searchText;
      Response response;
      if(AppConstants.vendorType == VendorType.dokan) {
        response = await shopRepo.getSearchShopProductsList(searchText, storeID, offset);
      }else{
        response = await shopRepo.getSearchWcfmShopProductsList(searchText, storeID, offset);
      }
      if (response.statusCode == 200) {
        if (offset == 1) {
          _searchProductList = [];
          _isSearching = false;
          update();
        }
          response.body.forEach((product) async {
            ProductModel _product =  ProductModel.fromJson(product);
            if(_product.status == 'publish' && _product.type != 'grouped') {
              _searchProductList.add(_product);
            }
          });
      } else {
        _searchProductList = [];
        update();
      }
    }
      update();
    }



    void clearSearchList(){
      _searchProductList = null;
      update();
    }

}

