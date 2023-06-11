import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter_woocommerce/view/screens/html/model/pages_model.dart';
import 'package:flutter_woocommerce/view/screens/html/repository/html_repo.dart';
import 'package:get/get.dart';


class HtmlViewController extends GetxController{
  final HtmlRepository htmlRepository;
  HtmlViewController({@required this.htmlRepository});

  bool _isLoading = false;
  get isLoading=> _isLoading;
  String  _htmlPage;
  String get htmlPage => _htmlPage;
  PagesModel _pagesContent;
  PagesModel get pagesContent => _pagesContent;

  Future<void> getPagesContent() async {
    Response response =await htmlRepository.getPagesContent();
    if(response.statusCode == 200){
      _pagesContent = PagesModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }
}
