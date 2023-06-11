import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter_woocommerce/view/screens/category/model/category_model.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/category/repository/category_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({@required this.categoryRepo});

  List<CategoryModel> _categoryList;
  List<CategoryModel> _subCategoryList;
  List<ProductModel> _categoryProductList;
  List<ProductModel> _searchProductList = [];
  bool _isLoading = false;
  bool _isSearching = false;
  int _subCategoryIndex = 0;
  String _searchText = '';
  String _prodResultText = '';
  int _offset = 1;

  List<CategoryModel> get categoryList => _categoryList;
  List<CategoryModel> get subCategoryList => _subCategoryList;
  List<ProductModel> get categoryProductList => _categoryProductList;
  List<ProductModel> get searchProductList => _searchProductList;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  int get subCategoryIndex => _subCategoryIndex;
  String get searchText => _searchText;
  String get prodResultText => _prodResultText;
  int get offset => _offset;


  Future<void> getCategoryList(bool reload, int offset) async {
    if(reload){
      _categoryList = null;
      update();
    }
      Response response = await categoryRepo.getCategoryList(offset);
      if (response.statusCode == 200) {
        if (offset == 1) {
          _categoryList = [];
        }
        response.body.forEach((category) => _categoryList.add(CategoryModel.fromJson(category)));
      } else {
        ApiChecker.checkApi(response);
      }
      update();
  }

  void getSubCategoryList(String categoryID) async {
    _subCategoryIndex = 0;
    _subCategoryList = null;
    _categoryProductList = null;
    Response response = await categoryRepo.getSubCategoryList(categoryID);
    if (response.statusCode == 200) {
      _subCategoryList= [];
      _subCategoryList.add(CategoryModel(id: int.parse(categoryID), name: 'all_category'.tr));
      response.body.forEach((category) => _subCategoryList.add(CategoryModel.fromJson(category)));
      getCategoryProductList(categoryID,1, false);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void setSubCategoryIndex(int index, String categoryID) {
    _subCategoryIndex = index;
    getCategoryProductList(_subCategoryIndex == 0 ? categoryID : _subCategoryList[index].id.toString(), 1, true);
  }

  void getCategoryProductList(String categoryID, int offset, bool notify) async {
    _offset = offset;
    if(offset == 1) {
      if(notify) {
        update();
      }
      _categoryProductList = null;
    }
    Response response = await categoryRepo.getCategoryProductList(categoryID, offset);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _categoryProductList = [];
      }
      response.body.forEach((product) {
        ProductModel _product = ProductModel.fromJson(product);
        if(_product.type != 'grouped') {
          _categoryProductList.add(_product);
        }
      });

      _isLoading = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void searchData(String query, String categoryID, int offset) async {
    if(query.isNotEmpty && query != _prodResultText) {
      _searchText = query;
      if(offset == 1) {
        _searchProductList = null;
        _isSearching = true;
      }
      update();

      Response response = await categoryRepo.getSearchData(query, categoryID, offset);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          _searchProductList = [];
        } else {
          if(offset == 1) {
            _prodResultText = query;
            _searchProductList = [];
          }
          response.body.forEach((product) {
            ProductModel _product = ProductModel.fromJson(product);
            if(_product.type != 'grouped') {
              _searchProductList.add(_product);
            }
          });
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    _searchProductList = [];
    if(_categoryProductList != null) {
      _searchProductList.addAll(_categoryProductList);
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

}
