import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/cart_model.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/product/model/review_model.dart';
import 'package:flutter_woocommerce/view/screens/product/model/variation_model.dart';
import 'package:flutter_woocommerce/view/screens/product/repository/product_repo.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/screens/wish/controller/wish_controller.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo productRepo;
  ProductController({@required this.productRepo});

  List<ProductModel> _productList;
  List<ProductModel> _saleProductList;
  List<ProductModel> _popularProductList;
  List<ProductModel> _reviewedProductList;
  List<ProductModel> _relatedProductList;
  List<ProductModel> _groupedProductList;
  List<VariationModel> _variations = [];
  List<ReviewModel> _reviewList;
  List<int> _variationIndex;
  int _quantity = 1;
  int _orderNowQuantity = 1;
  int _imageIndex = 0;
  double _startingPrice;
  double _startingDiscountedPrice;
  double _endingPrice;
  double _endingDiscountedPrice;
  bool _hasDiscount = false;
  int _cartIndex = -1;
  ProductModel _product;
  int _productSelect = 0;
  int _imageSliderIndex = 0;
  bool _isInitLoading = false;
  bool _isLoading = false;
  int _tabIndex = 0;
  PageController _pageController = PageController();
  bool _isWished = false;
  String _productDynamicUrl;
  List<String> _splitProductLink;
  String _productSlug;
  int _topProductIndex = 0;
  int _ratingIndex = -1;
  int _reviewId = 0;
  List<GroupedProduct> _groupedProduct;
  bool _isUpdate = false;
  int _existProductIndex = -1;
  int _productCartQty = 0;
  List<Attributes> _variationAttributes = [];
  List<Attributes> _productAttributes = [];
  String
  _filterOpVariationText = '' ;
  Timer _timer;
  List<int> _productDetailsIdList = [];
  List<double> _priceList = [];
  List<double> _discountedPriceList = [];
  int _stock;
  CartModel _cartModel;
  double _priceWithQuantity = 0;
  String _variationImage;
  int _variationRegPrice;
  bool _variationStock = false;
  int _variationStockQty;

  List<ProductModel> get productList => _productList;
  List<ProductModel> get saleProductList => _saleProductList;
  List<ProductModel> get popularProductList => _popularProductList;
  List<ProductModel> get reviewedProductList => _reviewedProductList;
  List<ProductModel> get relatedProductList => _relatedProductList;
  List<ProductModel> get groupedProductList => _groupedProductList;
  List<VariationModel> get variations => _variations;
  List<ReviewModel> get reviewList => _reviewList;
  List<int> get variationIndex => _variationIndex;
  int get quantity => _quantity;
  int get orderNowQuantity => _orderNowQuantity;
  int get imageIndex => _imageIndex;
  int get cartIndex => _cartIndex;
  ProductModel get product => _product;
  int get productSelect => _productSelect;
  int get imageSliderIndex => _imageSliderIndex;
  bool get isInitLoading => _isInitLoading;
  bool get isLoading => _isLoading;
  int get tabIndex => _tabIndex;
  PageController get pageController => _pageController;
  bool get isWished => _isWished;
  String get productDynamicUrl => _productDynamicUrl;
  int get topProductIndex => _topProductIndex;
  int get ratingIndex => _ratingIndex;
  List<GroupedProduct> get groupedProduct => _groupedProduct;
  bool get isUpdate => _isUpdate;
  int get reviewId => _reviewId;
  int get existProductIndex => _existProductIndex;
  int get productCartQty => _productCartQty;
  List<Attributes> get variationAttributes => _variationAttributes;
  List<Attributes> get productAttributes => _productAttributes;
  double get startingPrice => _startingPrice;
  double get startingDiscountedPrice => _startingDiscountedPrice;
  double get endingPrice => _endingPrice;
  double get endingDiscountedPrice => _endingDiscountedPrice;
  bool get hasDiscount => _hasDiscount;
  List<double> get priceList => _priceList;
  List<double> get discountedPriceList => _discountedPriceList;
  int get stock => _stock;
  CartModel get cartModel => _cartModel;
  double get priceWithQuantity => _priceWithQuantity;
  String get variationImage => _variationImage;
  int get variationRegPrice =>_variationRegPrice;
  bool get variationStock => _variationStock;
  int get variationStockQty => _variationStockQty;

  int _rating = 0;
  int get rating => _rating;
  final reviewController = TextEditingController();
  final reviewerNameController = TextEditingController();
  final reviewerEmailController = TextEditingController();

  void setRating(int rate) {
    _rating = rate;
    update();
  }


  Future<void> getProductList(int offset, bool reload) async {
    if(reload) {
      _productList = null;
      update();
    }
    Response _response = await productRepo.getProductList(offset);
    if (_response.statusCode == 200) {
      if (offset == 1) {
        _productList = [];
      }
      _response.body.forEach((product) {
          _productList.add(ProductModel.fromJson(product));
      });
      update();
    } else {
      ApiChecker.checkApi(_response);
    }
  }


  int selectedImages = 0;
  void setSelectedImage(int index){
    selectedImages = index;
    update();
  }


  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void initData(ProductModel product, CartModel cart, bool notify) {
    _variationIndex = [];
    if(cart != null) {
      _quantity = cart.quantity;
      List<String> _variationTypes = [];
      if(cart.variation.length != null && cart.variation.length > 0 && cart.variationText != null) {
        _variationTypes.addAll(cart.variationText.split('-'));
      }
      int _varIndex = 0;
      product.attributes.forEach((attributes) {
        for(int index=0; index<attributes.options.length; index++) {
          if(attributes.options[index].trim().replaceAll(' ', '') == _variationTypes[_varIndex].trim()) {
            _variationIndex.add(index);
            break;
          }
        }
        _varIndex++;
      });
    } else {
      _quantity = 1;
      _productAttributes.forEach((element) => _variationIndex.add(0));


      if(product.type == 'variable'){
        filterOp(0, 0);
      }

      setExistInCart(product, notify: false);
      getExistProductIndex(product.id);
    }
    if(notify) {
      update();
    }
  }

  void filterOp(int attributeIndex, int optionIndex) {
    for(int index = attributeIndex; index < _productAttributes.length; index++) {
      filterOption(index, index == attributeIndex ? optionIndex : 0);
    }
  }


  void filterOption(int attributeIndex, int optionIndex) {
    print('-------Attr: $attributeIndex/$optionIndex');
    if(_variationAttributes.isEmpty) {
      for(Attributes attribute in _productAttributes) {
        _variationAttributes.add(Attributes.fromJson(attribute.toJson()));
      }
    }

    if(attributeIndex < _variationAttributes.length-1) {
      for(int index = attributeIndex+1; index<_productAttributes.length; index++) {
        if(index > attributeIndex) {
          _variationAttributes[index].options =[];
        }
      }
    }

    if(attributeIndex == 1) {
      print('-------IInit options: ${_variationAttributes[1].options}');
    }

    if( attributeIndex+1 == _productAttributes.length){
      _variationAttributes[attributeIndex].options = [];
      print('last_index');
      _filterOpVariationText = '';
      print('LastVariation------------>${_variationAttributes[_variationAttributes.length -1].toJson()}');

      for(int i= 0; i <  _variationIndex.length -1; i++){
        String _optionText = '';
        if(_variationAttributes[i].options[_variationIndex[i]].contains(' ')){
          _optionText = _variationAttributes[i].options[_variationIndex[i]].replaceAll(' ', '');
        } else if (_variationAttributes[i].options[_variationIndex[i]].contains('-')) {
          _optionText = _variationAttributes[i].options[_variationIndex[i]].replaceAll('-', '');
        }else {
          _optionText = _variationAttributes[i].options[_variationIndex[i]] ;
        }
        filterOptionVText(_optionText.toLowerCase());
        //filterOptionVText(variationOptionTrimmedText(_variationAttributes[i].options[_variationIndex[i]]));
      }


      print('----------->${_variationIndex.toString()}');
      for (int i= 0; i<product.variation.length; i++ ) {
        if(product.variation[i].variation.contains(_filterOpVariationText)) {
          for(int j=0; j< product.attributes[_variationIndex.length -1].options.length; j++) {
            if(variationOptionTrimmedText(product.variation[i].attributes[_variationIndex.length -1].options)  == variationOptionTrimmedText(product.attributes[_variationIndex.length -1].options[j])) {
              _variationAttributes[attributeIndex].options.add(product.attributes[_variationIndex.length -1].options[j]);
              break;
            }
          }
          // _variationAttributes[attributeIndex].options.add(product.variation[i].attributes[_variationIndex.length -1].options);
          // break;
        }
      }
    } else
    if(attributeIndex < _productAttributes.length-1) {
      for(int variationIndex = 0; variationIndex < product.variation.length; variationIndex++) {

        if(variationIndex == 2) {
          print('variation_Index_2');
          print('---${_variationAttributes[attributeIndex].options}-----');
        }


        if(product.variation[variationIndex].attributes[attributeIndex].options == _variationAttributes[attributeIndex].options[optionIndex].toLowerCase().replaceAll(' ', '-')) {

          for(int attrIndex=attributeIndex+1; attrIndex<_productAttributes.length; attrIndex++) {
            if(attrIndex+1 == _productAttributes.length){
              print('attrIndex == _productAttr.length');
            }

            for(int opIndex=0; opIndex<_productAttributes[attrIndex].options.length; opIndex++) {
              if(_productAttributes[attrIndex].options[opIndex].toLowerCase().replaceAll(' ', '-') == product.variation[variationIndex].attributes[attrIndex].options.toLowerCase() && !_variationAttributes[attrIndex].options.contains(_productAttributes[attrIndex].options[opIndex])) {
                _variationAttributes[attrIndex].options.add(_productAttributes[attrIndex].options[opIndex].toString());
                break;
              }
            }
          }
        }
      }
    }
  }



  String filterOptionVText (String text) {
    if (_filterOpVariationText.isEmpty) {
      _filterOpVariationText += text;
    } else{
      _filterOpVariationText += '-'+text;
    }
    return _filterOpVariationText;
  }

  String variationOptionTrimmedText(String optionText) {
    String _optionText = '';
    if(optionText.contains(' ')){
      _optionText = optionText.replaceAll(' ', '');
    } else if (optionText.contains('-')) {
      _optionText = optionText.replaceAll('-', '');
    }else {
      _optionText = optionText;
    }
    return _optionText.toLowerCase();
  }




  int setExistInCart(ProductModel product, {bool notify = false}){
    List<String> _variationList = [];

/*    for (int index = 0; index < product.attributes.length; index++) {
      if(product.attributes[index].options.isNotEmpty) {
        _variationList.add(product.attributes[index].options[_variationIndex[index]].replaceAll(' ', '').toLowerCase());
      }
    }*/

    for (int index = 0; index < _variationAttributes.length; index++) {
      if(_variationAttributes[index].options.isNotEmpty) {
        _variationList.add(_variationAttributes[index].options[_variationIndex[index]].replaceAll(' ', '').toLowerCase());
      }
    }



    String variationType = '';
    bool isFirst = true;
    _variationList.forEach((variation) {
      if (isFirst) {
        variationType = '$variationType$variation';
        isFirst = false;
      } else {
        variationType = '$variationType-$variation';
      }
    });


    List<int> _productVariationIds = [];
    _product.variation.forEach((variation) {
      _productVariationIds.add(variation.id);
    });

    _cartIndex = Get.find<CartController>().isExistInCart(product.id, _productVariationIds, variationType, false, null);

    if(_cartIndex != -1) {
      _quantity = Get.find<CartController>().cartList[_cartIndex].quantity;
    }
    for (int index=0; index < _product.variation.length; index++) {
      // if (variationType == _variations[index].variation) {
      //   for(int ind=0; ind < product.images.length; ind++) {
      //     if(product.images[ind].id == _variations[index].image) {
      //       try {
      //         _pageController.jumpToPage(ind);
      //         setImageSliderIndex(ind, notify: false);
      //       }catch(e) {}
      //       break;
      //     }
      //   }
      //   break;
      // }
    }
    if(notify) {
      update();
    }
    return _cartIndex;
  }

  void getExistProductIndex (int productId) {
    _productCartQty = 0;
    if(Get.find<CartController>().cartList.length != 0) {
    for(int i=0; i < Get.find<CartController>().cartList.length; i++) {
        if(Get.find<CartController>().cartList[i].id == productId){
          _existProductIndex = i;
          _productCartQty += Get.find<CartController>().cartList[i].quantity;
        }
      }
    }
  }

  void setCartVariationIndex(int index, int i, ProductModel product) {
    _variationIndex[index] = i;
    if(index < (product.attributes.length-1)) {
      for (int x = index + 1; x < product.attributes.length; x++) {
        _variationIndex[x] = 0;
      }
    }
    if(product.type == 'variable'){
      filterOp(index, i);
    }

    _quantity = 1;
    setExistInCart(product);
    update();
  }

/*  void setCartVariationIndex(int index, int i, ProductModel product) {
    _variationIndex[index] = i;
    print('variationIndex :');
    print(i);
    print(index);
    _quantity = 1;
    setExistInCart(product);
    update();
  }*/

  void setImageIndex(int index, bool notify) {
    _imageIndex = index;
    if(notify) {
      update();
    }
  }

  Future<void> getProductDetails(ProductModel product, {bool notify = false, bool formBack = false}) async {
    _productAttributes = [];
    _variationAttributes = [];
    _product = null;
    _variations = null;
    _reviewList = null;
    _relatedProductList = null;
    _tabIndex = 0;
    if(!formBack){
      _productDetailsIdList.add(product.id);
    }
    if(notify){
      _isLoading = true;
      update();
    }
      Response response = await productRepo.getProductDetails(product.id);
      if (response.statusCode == 200) {
        _product = null;
        _product = ProductModel.fromJson(response.body);
      } else {
        showCustomSnackBar(response.statusText);
      }
    //}

    for(int index= 0; index<_product.variation.length; index++) {
      String _variationText = '';
      bool _first = true;
      for(int i=0; i<_product.variation[index].attributes.length; i++){
        String _optionText = '';
        if(_product.variation[index].attributes[i].options.contains(' ')){
          _optionText = _product.variation[index].attributes[i].options.replaceAll(' ', '');
        } else if (_product.variation[index].attributes[i].options.contains('-')) {
          _optionText = _product.variation[index].attributes[i].options.replaceAll('-', '');
        }else {
          _optionText = _product.variation[index].attributes[i].options ;
        }
        _variationText += (_optionText.isNotEmpty ? _first ? '' : '-' : '') + _optionText.toLowerCase();
        _first = false;
      }
      _product.variation[index].variation = _variationText;
    }

    for(int i =0; i < _product.attributes.length; i++) {
      if(i==0){
        _productAttributes = [];
      }
      _productAttributes.add(
          Attributes(
            name: _product.attributes[i].name,
            options: [],
          )
      );

      for(int j =0; j < _product.variation.length; j++) {
        for(int k = 0; k < _product.attributes[i].options.length; k++) {
          String _attributeOption = '';
          String _variationOption = '';
          _attributeOption = _product.attributes[i].options[k].replaceAll(' ', '');
          if(_product.variation[j].attributes[i].options.contains(' ')){
            _variationOption = _product.variation[j].attributes[i].options.replaceAll(' ', '');
          } else if (_product.variation[j].attributes[i].options.contains('-')) {
            _variationOption = _product.variation[j].attributes[i].options.replaceAll('-', '');
          }else {
            _variationOption = _product.variation[j].attributes[i].options;
          }

          if( _attributeOption.toLowerCase() == _variationOption.toLowerCase()) {
            if( !_productAttributes[i].options.contains(_product.attributes[i].options[k]) ){
              _productAttributes[i].options.add(_product.attributes[i].options[k]);
              break;
            }
          }
        }
      }
    }

    for (int i = 0; i <_productAttributes.length; i++ ) {
      print(_productAttributes[i].toJson());
    }

    initData(_product, null, _product.variation.length > 0);
    //setExistInCart(product, notify: false);
    if (_product.relatedIds.isNotEmpty) {
      getRelatedProducts(_product.relatedIds);
    }

    if(notify){
      _isLoading = false;
      update();
    }
  }


  void productDetailsBack() {
    _productDetailsIdList.removeAt(_productDetailsIdList.length-1);
    if(_productDetailsIdList.length >= 1){
      getProductDetails( ProductModel(id: _productDetailsIdList[_productDetailsIdList.length - 1]), notify: true, formBack: true);
    }
  }


  Future<void> getProductVariations(ProductModel product) async {
    Response response = await productRepo.getProductVariations(product.id);
    if (response.statusCode == 200) {
      _variations = [];
      response.body.forEach((productModel) {
        ProductModel _p = ProductModel.fromJson(productModel);
        VariationModel _variation = VariationModel(
          id: _p.id, parentId: product.id, price: _p.price, regularPrice: _p.regularPrice, salePrice: _p.salePrice,
          dateOnSaleFrom: _p.dateOnSaleFrom, dateOnSaleTo: _p.dateOnSaleTo, onSale: _p.onSale, manageStock: product.manageStock,
          stockQuantity: _p.stockQuantity, attributes: [], variation: '',
          image: productModel['image'] != null ? productModel['image']['id'] : 0,
        );
        productModel['attributes'].forEach((attribute) {
          _variation.attributes.add(AttributesModel.fromJson(attribute));
          _variation.variation += (_variation.variation.isNotEmpty ? '-' : '') + AttributesModel.fromJson(attribute).option;
        });
        _variations.add(_variation);
      });
    } else {
      showCustomSnackBar(response.statusText);
    }
  }

  void setSelect(int select, bool notify){
    _productSelect = select;
    if(notify){
      update();
    }
  }

  void setImageSliderIndex(int index, {bool notify = true}) {
    _imageSliderIndex = index;
    if(notify) {
      update();
    }
  }

  void setTabIndex(int index, int productID) {
    _tabIndex = index;
    if(index == 2 && _reviewList == null) {
      getProductReviews(productID);
    }
    update();
  }

  void setQuantity(bool isIncrement, int stock, {bool test = false, bool isOrderNow = false}) {
    if (isIncrement) {
      if(isOrderNow) {
        if(stock != null && _orderNowQuantity >= stock) {
          Get.back();
          showCustomSnackBar('out_of_stock'.tr);
        }else {
          _orderNowQuantity = _orderNowQuantity + 1;
        }
      }else {
        if(stock != null && _quantity >= stock) {
          Get.back();
          showCustomSnackBar('out_of_stock'.tr);
        }else {
          _quantity = _quantity + 1;
        }
      }
    } else {
      if(isOrderNow) {
        _orderNowQuantity = _orderNowQuantity - 1;
      }else{
        _quantity = _quantity - 1;
      }
    }
    update();
  }

  Future<void> getSaleProductList(bool reload, bool notify, int offset) async {
    if(offset == 1) {
      _saleProductList = null;
    }
    if(notify) {
      update();
    }
      Response _response = await productRepo.getSaleProductList(offset);
      if(_response.statusCode == 200) {
        if(offset == 1) {
          _saleProductList = [];
        }
        _response.body.forEach((product) {
          ProductModel _product  = ProductModel.fromJson(product);
          if(_product.type != 'grouped') {
            _saleProductList.add(_product);
          }
        });
      }else {
        showCustomSnackBar(_response.statusText);
      }
      update();
  }

  Future<void> getPopularProductList(bool reload, bool notify, int offset) async {
    if(offset == 1) {
      _popularProductList = null;
    }
    if(notify) {
      update();
    }

      Response _response = await productRepo.getPopularProductList(offset);
      if(_response.statusCode == 200) {
        if(offset == 1) {
          _popularProductList = [];
        }
        _response.body.forEach((product) {
          ProductModel _product = ProductModel.fromJson(product);
          if(_product.type != 'grouped') {
            _popularProductList.add(_product);
          }
        });
      }else {
        showCustomSnackBar(_response.statusText);
      }
      update();
  }

  Future<void> getReviewedProductList(bool reload, bool notify) async {
    if(reload) {
      _reviewedProductList = null;
    }
    if(notify) {
      update();
    }
    if(_reviewedProductList == null || reload) {
      Response _response = await productRepo.getReviewedProductList();
      if(_response.statusCode == 200) {
        _reviewedProductList = [];
        _response.body.forEach((product) {
          ProductModel _product = ProductModel.fromJson(product);
          if(_product.type != 'grouped') {
            _reviewedProductList.add(_product);
          }
        });
        if(_reviewedProductList.isNotEmpty) {
          _timer?.cancel();
          _topProductIndex = 0;
          _timer = Timer.periodic(Duration(seconds: 5), (timer) {
            _topProductIndex = (_topProductIndex == _reviewedProductList.length - 1) ? 0 : (_topProductIndex + 1);
            update();
          });
        }
      }else {
        showCustomSnackBar(_response.statusText);
      }
      update();
    }
  }

  Future<void> getRelatedProducts(List<int> productIDs) async {
    String _relatedIds = '';
    for(int id in productIDs) {
      _relatedIds += '${_relatedIds.isNotEmpty ? ',' : ''}' + id.toString();
    }
    Response response = await productRepo.getRelatedProducts(_relatedIds);
    if (response.statusCode == 200) {
      _relatedProductList = [];
      response.body.forEach((review) {
        ProductModel _product = ProductModel.fromJson(review);
        if(_product.type != 'grouped') {
          _relatedProductList.add(_product);
        }
      });
    } else {
      showCustomSnackBar(response.statusText);
    }
    update();
  }

  Future<void> getGroupedProducts(List<int> productIDs) async {
    String _relatedIds = '';
    for(int id in productIDs) {
      _relatedIds += '${_relatedIds.isNotEmpty ? ',' : ''}' + id.toString();
    }
    Response response = await productRepo.getRelatedProducts(_relatedIds);
    if (response.statusCode == 200) {
      _groupedProductList = [];
      response.body.forEach((review) {
        ProductModel _product = ProductModel.fromJson(review);
        if(_product.type != 'grouped') {
          _groupedProductList.add(_product);
        }
      });
    } else {
      showCustomSnackBar(response.statusText);
    }
    update();
  }

  Future<void> clearGroupedProducts({bool notNull = false, bool notify = true}) async {
    _groupedProductList = null;
    if(notNull){
      _groupedProductList = [];
    }
    if (notify) {
      update();
    }
  }


  Future<void> getProductReviews(int productID, {bool formWriteReview = false, String userMail}) async {
    _isInitLoading = true;
    _ratingIndex = -1;
    reviewController.text = '';
    _isUpdate = false;
    _reviewId = 0;
    update();
    Response response = await productRepo.getProductReviews(productID);
    if (response.statusCode == 200) {
      _reviewList = [];
      if(formWriteReview) {
        response.body.forEach((review) {
          ReviewModel _reviewModel = ReviewModel.fromJson(review);
          if(_reviewModel.email == userMail) {
            // setReviewData(_reviewModel);
          }
        });
      }else {
        response.body.forEach((review) => _reviewList.add(ReviewModel.fromJson(review)));
      }
      _reviewList.reversed.toList();
    } else {
      showCustomSnackBar(response.statusText);
    }
    _isInitLoading = false;
    update();
  }

  void setReviewData(ReviewModel reviewModel) {
    _ratingIndex = reviewModel.rating - 1;
    reviewController.text = reviewModel.review;
    _isUpdate = true;
    _reviewId = reviewModel.id;
    update();
  }


  String getImageUrl(List<ImageModel> images) => images.length > 0 ? images[0].src : '';

  getWished(ProductModel product){
    Get.find<WishListController>().wishList.forEach((element){
      if(element.productId == product.id){
        _isWished=true;
      }else{
        _isWished=false;
      }
    });
  }


  Future<void> submitReview(SubmitReviewModel review) async {
    _isLoading = true;
    update();
    Response response = await productRepo.postReviewSubmit(review);
      if (response.statusCode == 201) {
        await  getProductDetails(ProductModel(id: review.productId));
        showCustomSnackBar( 'review_submitted_successfully'.tr, isError: false);
        Get.back();
        emptyFormData();
        } else {
      }
    _isLoading = false;
    update();
  }

  void emptyFormData() {
    _ratingIndex = -1;
    reviewController.text = '';
    reviewerEmailController.text ='';
    reviewerNameController.text ='';
  }

  Future<void> updateReview(SubmitReviewModel review, int reviewId) async {
    _isLoading = true;
    update();
    Response response = await productRepo.updateProductReview(review, reviewId);
    if(response.statusCode == 200) {
      showCustomSnackBar('review_updated_successfully'.tr, isError: false);
    }else if(response.statusCode == 201) {
      _ratingIndex = -1;
      reviewController.text = '';
      Get.back();
    } else {
    }
    _isLoading = false;
    update();
  }



  void shareProductLink({String productSlug}) async {
    // DynamicLinkParameters productParams = DynamicLinkParameters(
    //   uriPrefix:  AppConstants.DYNAMIC_LINK_URI_PREFIX,
    //   link: Uri.parse(AppConstants.DYNAMIC_LINK_URL+productSlug),
    //   androidParameters: AndroidParameters(
    //     packageName: AppConstants.APP_PACKAGE_NAME,
    //     minimumVersion: 0,
    //   ),
    //   // iosParameters: IOSParameters(
    //   //   bundleId: firebaseDynamicLinkConfig['iOSBundleId'],
    //   //   minimumVersion: firebaseDynamicLinkConfig['iOSAppMinimumVersion'],
    //   //   appStoreId: firebaseDynamicLinkConfig['iOSAppStoreId'],
    //   // ),
    // );

    //var shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(productParams);
    var shortDynamicLink = AppConstants.BASE_URL+'/product/$productSlug';
    if(shortDynamicLink != null){
       Share.share(shortDynamicLink);
    }else{
      showCustomSnackBar('Failed to generate link', isError: true);
    }
  }


  void initDynamicLinks() async {
    _splitProductLink = [];
    _productSlug = '';
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
       _splitProductLink =  dynamicLinkData.link.toString().split('/');
       _productSlug= _splitProductLink[_splitProductLink.length-1];
       Get.toNamed(RouteHelper.getProductDetailsRoute(-1,_productSlug, false));
       getSlugProductDetails('',false);
    }).onError((e) {
       print('[firebase-dynamic-link] error: ${e.message}');
    });
  }


  Future<void> getSlugProductDetails(String slug,bool formSplash) async {
    _product = null;
    _variations = null;
    _reviewList = null;
    _relatedProductList = null;
    _tabIndex = 0;
    _product = null;
    if(formSplash) {
      _splitProductLink = [];
      _productSlug = '';
      _splitProductLink = slug.split('/');
      _productSlug = _splitProductLink[_splitProductLink.length-1];
    }
    Response response = await productRepo.getSlugProductDetails(_productSlug);
    if (response.statusCode == 200) {
      _product = ProductModel.fromJson(response.body[0]);
    } else {
      showCustomSnackBar(response.statusText);
    }

    if(_product.variations.length > 0) {
      await getProductVariations(product);
    }else {
      _variations = [];
    }
    initData(_product, null, _product.variations.length > 0);
    setExistInCart(product, notify: false);
    getRelatedProducts(_product.relatedIds);
  }

  void setTopProductIndex ( bool isRight ) {
    if (isRight) {
      _topProductIndex = _topProductIndex + 1;
    } else {
      _topProductIndex = _topProductIndex - 1;
    }
    update();
  }

  void setCurrentIndex(int index){
    _topProductIndex = index;
    update();
  }

  void setRatingIndex(int index) {
    if(index == 0  && _ratingIndex == 0) {
      _ratingIndex = -1;
    } else {
      _ratingIndex = index;
    }
    update();
  }

  resetImageIndex() {
    _imageIndex = 0;
    update();
  }

  Future<void> getGroupedProductList(bool reload, bool notify, int offset) async {
    if(offset == 1) {
      _groupedProduct = null;
    }
    if(notify) {
      update();
    }

      Response _response = await productRepo.getGroupedProductList(offset);
      if(_response.statusCode == 200) {
        if(offset == 1){
          _groupedProduct = [];
        }
        _response.body.forEach((product) {
          _groupedProduct.add(GroupedProduct.fromJson(product));
        });
      }else {
        showCustomSnackBar(_response.statusText);
      }
      update();
  }


  void calculateProductPrice(ProductModel product) {
    _priceList = [];
    _discountedPriceList =[];

    if(product.variation.length != 0) {
      product.variation.forEach((variation) {
        if(variation.regularPrice != null && variation.regularPrice.toString().trim().isNotEmpty) {
          // if (variation.salePrice != null && variation.salePrice.toString().trim().isNotEmpty) {
          _priceList.add(double.parse(variation.regularPrice.toString()));
          // }
        }else {
          _priceList.add(0);
        }
      });

      product.variation.forEach((variation) {
        if (variation.salePrice != null) {
          _hasDiscount = true;
          _discountedPriceList.add(double.parse(variation.salePrice.toString()));
        } else if (variation.regularPrice != null){
          _discountedPriceList.add(double.parse(variation.regularPrice.toString()));
        }
      });

      _priceList.sort((a, b) => a.compareTo(b));
      _discountedPriceList.sort((a, b) => a.compareTo(b));
      _startingPrice = _priceList[0];
      if(_discountedPriceList.length > 0) {
        _startingDiscountedPrice = _discountedPriceList[0];
      }
      if(_priceList[0] < _priceList[_priceList.length-1]) {
        _endingPrice = _priceList[_priceList.length-1];
      }
      if(_discountedPriceList.length > 0 && _discountedPriceList[0] < _discountedPriceList[_discountedPriceList.length-1]) {
        _endingDiscountedPrice = _discountedPriceList[_discountedPriceList.length-1];
      }
    }else {
      _hasDiscount = product.salePrice.isNotEmpty;
      _startingPrice = product.regularPrice != '' ? double.parse(product.regularPrice) : 0;
      _startingDiscountedPrice = product.regularPrice != '' ? double.parse(product.price) : 0;
    }
  }


  void  createProductCartModel(ProductModel product, bool orderNow) {
    _variationImage = null;
    _variationRegPrice = null;
    _variationStock = false;
    _variationStockQty = null;
    _stock = null;
    if(product != null && _variationIndex != null) {
      List<String> _variationList = [];


      if(_variationAttributes.isNotEmpty) {
        if (product.variation.isNotEmpty) {
          for (int index = 0; index < _variationAttributes.length; index++) {
            if (_variationAttributes.isNotEmpty) {
              _variationList.add(_variationAttributes[index].options[_variationIndex[index]].replaceAll(' ', ''));
            }
          }
        }
      }


      String variationType = '';
      bool isFirst = true;
      _variationList.forEach((variation){
        if (isFirst) {
          variationType = '$variationType${variation.toLowerCase()}';
          isFirst = false;
        } else {
          variationType = '$variationType-${variation.toLowerCase()}';
        }
      });

      double price = product.regularPrice != ''? double.parse(product.regularPrice ?? '0'):0;
      double priceWithDiscount = product.price != '' ? double.parse(product.price) : 0;
      int _id = product.id;

      for (int index=0; index< product.variation.length; index++) {

        if (variationType == product.variation[index].variation) {
          print(product.variation[index].variation);
          price = product.variation[index].regularPrice.toString() != ''? double.parse(product.variation[index].regularPrice.toString()) : 0;
          priceWithDiscount = product.variation[index].price.toString() != ''? double.parse(product.variation[index].price.toString()) : 0;
          _id = product.variation[index].id;
          if (product.variation[index].variationImage.src != null) {
            _variationImage = product.variation[index].variationImage.src;
          }
          if(product.variation[index].regularPrice != null) {
            _variationRegPrice = product.variation[index].regularPrice * _quantity;
          }
          if(product.variation[index].manageStock != null) {
            _variationStock = product.variation[index].manageStock;
          }

          if(product.variation[index].stockQuantity != null) {
            _variationStockQty = product.variation[index].stockQuantity;
          }
          break;
        } else {
          _variationImage = null;
          _variationRegPrice = null;
          _variationStock = false;
          _variationStockQty = null;
        }
      }

      List<Variation> _variations = [];
      for(int index=0; index< product.attributes.length; index++) {
        if(product.variation.isNotEmpty) {
          if (product.attributes.isNotEmpty) {
            _variations.add(Variation(
              attribute: _product.attributes[index].name,
              value: _product.attributes[index].options[_variationIndex[index]],
            ));
          }
        }
      }

      if(_variationStock){
        if(_variationStockQty != null) {
          _stock =  _variationStockQty - (_cartIndex != -1 ?  Get.find<CartController>().cartList[_cartIndex].quantity != null ? Get.find<CartController>().cartList[_cartIndex].quantity : 0 : 0);
        }
      }
      else if ( product.stockQuantity != null ) {
        _stock = product.stockQuantity - ( _cartIndex == null ? 0 :(_cartIndex != -1 ? Get.find<CartController>().cartList[_cartIndex].quantity != null ? Get.find<CartController>().cartList[_cartIndex].quantity : 0 : 0));
      }else{
        _stock = null;
      }


      _priceWithQuantity = priceWithDiscount * _quantity;

      _cartModel = CartModel(
        id: _id, quantity: orderNow ? _orderNowQuantity : _quantity, quantityLimits: QuantityLimits(minimum: 1, maximum: _variationStock ? _variationStockQty : _stock),
        name: _product.name, shortDescription: _product.shortDescription,
        description: _product.description, sku: _product.sku,
        images: _product.images != [] ? _product.images : [], variation: _variations, variationText: variationType,
        prices: Prices(price: priceWithDiscount.toString(), regularPrice: price.toString(), salePrice: priceWithDiscount.toString()),
        product: _product, variationImage: variationImage,
      );

      if(!_product.manageStock){
        _stock = null;
      }
    }
  }

}