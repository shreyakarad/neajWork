import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';
import 'package:flutter_woocommerce/view/screens/search/repository/search_repo.dart';
import 'package:get/get.dart';

class SearchController extends GetxController implements GetxService {
  final SearchRepo searchRepo;
  SearchController({@required this.searchRepo});

  bool _isSearchMode = true;
  String _searchText = '';
  String _prodResultText = '';
  List<ProductModel> _allProductList;
  List<ProductModel> _searchProductList;
  int _sortIndex = -1;
  double _upperValue = 0;
  double _lowerValue = 0;
  List<String> _historyList = [];


  bool get isSearchMode => _isSearchMode;
  String get searchText => _searchText;
  String get prodResultText => _prodResultText;
  List<ProductModel> get allProductList => _allProductList;
  List<ProductModel> get searchProductList => _searchProductList;
  int get sortIndex => _sortIndex;
  double get upperValue => _upperValue;
  double get lowerValue => _lowerValue;
  List<String> get historyList => _historyList;

  void setSearchMode(bool isSearchMode) {
    _isSearchMode = isSearchMode;
    if(isSearchMode) {
      _searchText = '';
      _prodResultText = '';
      _allProductList = null;
      _searchProductList = null;
      _sortIndex = -1;
      //_rating = -1;
      _upperValue = 0;
      _lowerValue = 0;
    }
    update();
  }

  void searchData(String query, int offset) async {
    //  && query != _prodResultText
    if((query.isNotEmpty)) {
      _searchText = query;
     // _rating = -1;


      if(offset ==1) {
        _upperValue = 0;
        _lowerValue = 0;
        _searchProductList = null;
        _allProductList = null;
      }



      if (!_historyList.contains(query)) {
        _historyList.insert(0, query);
      }
      searchRepo.saveSearchHistory(_historyList);
      _isSearchMode = false;
      update();

      Response response = await searchRepo.getSearchData(query, offset);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          _searchProductList = [];
        } else {
            _prodResultText = query;
            if(offset == 1){
              _searchProductList = [];
            }
            _allProductList = [];
            //_searchProductList.addAll(ProductModel.fromJson(response.body));
            response.body.forEach((item) async{
              ProductModel _product = ProductModel.fromJson(item);
              if( _product.type != 'grouped') {
                _searchProductList.add(_product);
              }
            });
          //  _allProductList.addAll(ProductModel.fromJson(response.body));
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }






  void getHistoryList() {
    _searchText = '';
    _historyList = [];
    _historyList.addAll(searchRepo.getSearchAddress());
  }

  void removeHistory(int index) {
    _historyList.removeAt(index);
    searchRepo.saveSearchHistory(_historyList);
    update();
  }

  void clearSearchAddress() async {
    searchRepo.clearSearchHistory();
    _historyList = [];
    update();
  }

}
