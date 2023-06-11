import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter_woocommerce/view/screens/home/model/banner_model.dart';
import 'package:flutter_woocommerce/view/screens/home/repository/banner_repo.dart';
import 'package:get/get.dart';

class BannerController extends GetxController implements GetxService {
  final BannerRepo bannerRepo;
  BannerController({@required this.bannerRepo});

  List<BannerModel> bannerList = [];
  bool _isSafeArea = false;
  bool get isSafeArea => _isSafeArea;

  Future<void> getBannerList() async {
    bannerList = [];
    Response response = await bannerRepo.getBannerList();
    if(response.statusCode == 200){
      response.body.forEach((banner) {
        BannerModel _banner = BannerModel.fromJson(banner);
        if (_banner.bannerType == 'main') {
          bannerList.add(_banner);
        }
      });
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  void setSafeAreaTrue() {
    _isSafeArea = true;
    update();
  }
  void setSafeAreaFalse() {
    _isSafeArea = false;
    update();
  }




}
